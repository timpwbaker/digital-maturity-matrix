require 'rails_helper'

feature 'View Submission', :devise do
  scenario 'view a submission as html' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_matrix_submission_path(1)
    page.find('#submit-button').click
    visit matrix_submission_path(1, Submission.find_by_user_id(user.id))
    expect(page).to have_content('Created by:')
  end

  scenario 'view a submission as html' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_matrix_submission_path(1)
    page.find('#submit-button').click
    visit matrix_submission_path(1, Submission.find_by_user_id(user.id), format: :pdf)
    expect(response).to have_http_status(200)
  end
end
