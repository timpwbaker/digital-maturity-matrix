require "rails_helper"

RSpec.feature "User views submissions index" do
  scenario "As admin user" do
    user = FactoryGirl.create :user, admin: true
    submission = FactoryGirl.create :submission

    signin(user.email, user.password)

    visit matrix_submissions_path(submission.matrix)

    expect(page).to have_content submission.user.name
  end

  scenario "As standard user" do
    user = FactoryGirl.create :user
    submission = FactoryGirl.create :submission

    signin(user.email, user.password)

    visit matrix_submissions_path(submission.matrix)

    expect(page).to have_content "You do not have access to this area"
  end
end
