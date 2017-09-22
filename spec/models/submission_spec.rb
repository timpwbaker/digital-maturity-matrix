require "rails_helper"

RSpec.describe Submission, "associations" do
  it { should belong_to :matrix }
  it { should belong_to :user }
  it { should have_many :answers }
  it { should have_many :targets }
end
