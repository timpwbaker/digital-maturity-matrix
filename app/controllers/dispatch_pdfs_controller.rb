class DispatchPdfsController < ApplicationController
  def create
    if !submission.s3_url
      create_and_save_pdf
    end
    if target == 'email'
      UserMailer.matrix_pdf(current_user, submission.s3_url).deliver_later
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
    submission.matrix
  end

  def target
    params[:target]
  end

  def create_and_save_pdf
    rand = SecureRandom.hex
    date = Date.today
    render  locals: { submission: submission},
            javascript_delay: 2000,
            pdf:       'submission',
            layout:    'pdf',
            template:  'submissions/showpdf.html.erb',
            show_as_html: params.key?('debug'),
            save_to_file: Rails.root.join('app', 'pdf', "#{submission.user.organisation}_#{date}_submission#{rand}.pdf"),
            save_only: true
    submission.update_attribute(:s3_url, to_s3_return_url(s3_resource, rand, date, submission.user.organisation))
  end

  def to_s3_return_url(s3, rand, date, org)
    obj = s3.bucket('digital-maturity-matrix').object("#{org}_#{date}_submission#{rand}.pdf")
    obj.upload_file(Rails.root.join('app', 'pdf', "#{org}_#{date}_submission#{rand}.pdf"), acl:'public-read')
    return obj.public_url
  end

  def s3_resource
    Aws::S3::Resource.new(credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
                          region: ENV['AWS_REGION'])
  end
end
