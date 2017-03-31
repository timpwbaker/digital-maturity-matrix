class DownloadPdfsController < ApplicationController

  def create
    if !submission.s3_url
      create_and_save_pdf
    end
    redirect_to submission.s3_url
  end

  private

  def matrix
    Matrix.find(params[:matrix_id])
  end

  def submission
    Submission.find(params[:submission_id])
  end

  def create_and_save_pdf
    rand = SecureRandom.hex
    date = Date.today
    render  locals: { matrix: matix, submission: submission },
            javascript_delay: 2000,
            pdf:       'submission',
            layout:    'pdf',
            template:  'submissions/showpdf.html.haml',
            show_as_html: params.key?('debug'),
            save_to_file: Rails.root.join('app', 'pdf', "#{submission.user.organisation}_#{date}_submission#{rand}.pdf"),
            save_only: true
    submission.s3_url = to_s3_return_url(rand, date, submission.user.organisation)
    submission.save
  end
end
