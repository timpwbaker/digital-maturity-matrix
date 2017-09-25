require 'rails_helper'

RSpec.describe User, "associations" do
  it { should have_one :brand }
  it { should have_one :submission }
  it { should accept_nested_attributes_for :brand }
end

RSpec.describe User, "validations" do
  it { should validate_presence_of :name }
  it { should validate_presence_of :organisation }
  it { should validate_presence_of :organisation_turnover }
  it { should validate_presence_of :organisation_size }
  it { should validate_presence_of :digital_size }
end

RSpec.describe User, "#send_welcome_email" do
  it "shoud send an email" do
    ActiveJob::Base.queue_adapter = :test
    user = FactoryGirl.create :user

    expect {
      user.send_welcome_email
    }.to have_enqueued_job.on_queue('mailers')
  end
end
