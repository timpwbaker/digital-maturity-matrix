require "rails_helper"

RSpec.describe Question, "associations" do
  it { should belong_to :matrix }
end

RSpec.describe Question, "validations" do
  it { should validate_presence_of :body }
end
