class DispatchPdfsController < ApplicationController
  def create
    PdfBuilder.build(submission: submission)
    if target == 'email'
      UserMailer.matrix_pdf(current_user, submission.s3_url).deliver_now
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
end
