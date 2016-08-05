require 'rails_helper'

feature 'Create submission', :devise do
  scenario 'create successful submission' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_matrix_submission_path(1)
    page.find('#submit-button').click
    expect(page).to have_content('Created by:')
  end
end
