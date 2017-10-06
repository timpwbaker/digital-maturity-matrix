require "rails_helper"

RSpec.describe UserMailer, "welcome_email" do
  it "sends welcome email" do
    stub_aws_return_matrix
    stub_aws_post_return_200
    stub_aws_client

    user = build_stubbed :user
    mail = UserMailer.welcome_email(user).deliver_now

    expect(mail.subject).to eq "Welcome to the Digital Maturity Matrix"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["digital@breastcancercare.com"]
    expect(mail.body.encoded).to match "Thank you for signing up"
  end
end

RSpec.describe UserMailer, "matrix_pdf" do
  it "sends welcome email" do
    stub_aws_return_matrix
    stub_aws_post_return_200
    stub_aws_client

    user = build_stubbed :user
    file_url = "https://digitalmaturitymatrix.s3-eu-west-1.amazonaws.com/submission.pdf"
    mail = UserMailer.matrix_pdf(user, file_url).deliver_now

    expect(mail.subject).to eq "Your Digital Maturity Matrix"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["digital@breastcancercare.com"]
    expect(mail.body.encoded).to match "Your Maturity Matrix is attached."
  end
end
