require "rails_helper"

RSpec.describe Brand, "associations" do
  it { should belong_to :user }
end

RSpec.describe Brand, "validations" do
  it { should validate_presence_of :color_a }
  it { should validate_presence_of :color_b }
end
