require "rails_helper"

RSpec.describe Submission, "associations" do
  it { should belong_to :matrix }
  it { should belong_to :user }
end
