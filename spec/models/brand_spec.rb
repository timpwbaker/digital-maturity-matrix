require "rails_helper"

RSpec.describe Brand, "associations" do
  it { should belong_to :user }
end
