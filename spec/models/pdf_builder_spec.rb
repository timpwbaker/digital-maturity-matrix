require "rails_helper"

RSpec.describe PdfBuilder, ".build" do
  it "generates a pdf" do
    stub_aws_client
    stub_aws_post_return_200
    stub_aws_return_matrix

    submission = create :submission, s3_url: nil
    PdfBuilder.build(submission: submission)

    expect(submission.s3_url).not_to be nil
  end
end
