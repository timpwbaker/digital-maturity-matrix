require "rails_helper"

RSpec.describe Matrix, "associations" do
  it { should have_many :questions }
  it { should have_many :submissions }
end
