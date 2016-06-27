require 'rails_helper'

feature 'Create submission', :devise do
  scenario 'create successful submission' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_matrix_submission_path(1)
    page.find('#submit-button').click
    expect(page).to have_content('Created by:')
    page.find('#edit-submission-button').click
    select 'Strongly Disagree', from: 'submission_answers_attributes_36_choice'
    # page.find('#submission_answers_attributes_36_choice').find('agree').select_option
    page.find('#submit-button').click
    expect(page).to have_content('Current digital maturity: 98%')
    expect(page).to have_content('Current: 83%')
  end
end
