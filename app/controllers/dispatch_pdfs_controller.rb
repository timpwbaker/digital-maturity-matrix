class DispatchPdfsController < ApplicationController

  def create
    if !submission.s3_url
      create_and_save_pdf
    end
    if target == 'email'
      send_email_pdf(current_user.id, current_user.name,
                     current_user.email, submission.s3_url)
      redirect_to(
        matrix_submission_path(matrix, submission),
        notice: 'We have emailed you your PDF'
      )
    else
      redirect_to submission.s3_url
    end
  end

  private

  def submission
    Submission.find(params[:submission_id])
  end

  def matrix
    Matrix.find(params[:matrix_id])
  end

  def target
    params[:target]
  end

  def create_and_save_pdf
    rand = SecureRandom.hex
    date = Date.today
    render  locals: { matrix: matrix, submission: submission },
            javascript_delay: 2000,
            pdf:       'submission',
            layout:    'pdf',
            template:  'submissions/showpdf.html.haml',
            show_as_html: params.key?('debug'),
            save_to_file: Rails.root.join('app', 'pdf', "#{submission.user.organisation}_#{date}_submission#{rand}.pdf"),
            save_only: true
    submission.update_attribute(:s3_url, to_s3_return_url(rand, date, submission.user.organisation))
  end

  def to_s3_return_url(rand, date, org)
    s3 = Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
        region: ENV['AWS_REGION']
    )

    obj = s3.bucket(ENV['AWS_BUCKET']).object("#{org}_#{date}_submission#{rand}.pdf")
    obj.upload_file(Rails.root.join('app', 'pdf', "#{org}_#{date}_submission#{rand}.pdf"), acl:'public-read')
    puts obj.public_url
    return obj.public_url
  end

  def send_email_pdf(userid, username, useremail, fileurl)
    require 'open-uri'
    file = open(fileurl).read
    Pony.mail(
        to: useremail,
        from: 'digital@breastcancercare.org.uk',
        subject: 'Here’s your Third Sector Digital Maturity Matrix',
        html_body: '<h2>Hello ' + username + '.</h2>
        <p> Your Maturity Matrix is attached. We hope you find this useful.
        <p> We’d love to know what you think, so please email
        <a href="mailto:digital@breastcancercare.org.uk">digital@breastcancercare.org.uk</a>
        with any feedback or questions.
        <p >All the best
        <p> Breast Cancer Care Digital Team',
        attachments: {
            'matrix.pdf' => file
        }
    )
  end
end
