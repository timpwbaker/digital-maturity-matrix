require 'rails_helper'

RSpec.describe PdfBuilderWorker, "#perform"  do
  it 'enqueues a job' do
    submission = FactoryGirl.create :submission, s3_url: nil

    PdfBuilderWorker.perform_async(submission.id)

    expect {
      PdfBuilderWorker.perform_async(submission.id)
    }.to change(PdfBuilderWorker.jobs, :size).by(1)


  end

  it "generates a pdf" do
    stub_aws_client
    stub_aws_post_return_200
    stub_aws_return_matrix

    submission = FactoryGirl.create :submission, s3_url: nil

    Sidekiq::Testing.inline! do
      PdfBuilderWorker.perform_async(submission.id)
    end

    expect(submission.reload.s3_url).not_to be nil
  end
end
