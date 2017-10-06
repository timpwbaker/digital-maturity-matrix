class PdfBuilderWorker
  include Sidekiq::Worker

  def perform(submission_id)
    submission = Submission.find(submission_id)
    PdfBuilder.build(submission: submission)
  end
end
