require 'rails_helper'

RSpec.feature 'View Submission', :devise do
  scenario 'view your own submission as html' do
    user = FactoryGirl.create :user
    submission = FactoryGirl.create :submission, user: user

    signin(user.email, user.password)

    visit matrix_submission_path(submission.matrix, submission)

    expect(page).to have_content "#{user.organisation} Digital Maturity Matrix"
    expect(page).to have_content "Created by: #{user.name}"
  end

  scenario 'try to view someone elses submission' do
    user = FactoryGirl.create :user
    other_user = FactoryGirl.create :user
    submission = FactoryGirl.create :submission, user: other_user

    signin(user.email, user.password)

    visit matrix_submission_path(submission.matrix, submission)

    expect(page).to have_content "This doesn't appear to be your matrix."
  end

  scenario "tries to view submission when not logged in " do
    submission = FactoryGirl.create :submission

    visit matrix_submission_path(submission.matrix, submission)

    expect(page).to have_content "You need to sign in or sign up"
  end

  scenario "view someone elses submission as admin" do
    user = FactoryGirl.create :user
    admin = FactoryGirl.create :user, admin: true
    submission = FactoryGirl.create :submission, user: user

    signin(admin.email, admin.password)

    visit matrix_submission_path(submission.matrix, submission)

    expect(page).to have_content "#{user.organisation} Digital Maturity Matrix"
    expect(page).to have_content "Created by: #{user.name}"
  end
end
