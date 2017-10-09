require "rails_helper"

RSpec.feature "Admin manages users" do
  scenario "can see all the users" do
    FactoryGirl.create :user, name: "Mr A"
    admin = FactoryGirl.create :user, :admin

    signin(admin.email, admin.password)
    visit users_path

    expect(page).to have_content "Mr A"
  end
end
