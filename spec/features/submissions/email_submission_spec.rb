require 'rails_helper'

feature 'Email submission', :devise do
  scenario 'Email a submission' do
    stub_aws_client

    user = FactoryGirl.create(:user)
    matrix = FactoryGirl.create(:matrix)

    signin(user.email, user.password)
    visit new_matrix_submission_path(matrix)
    page.find('#submit-button').click
    click_button 'Email my PDF'

    expect(page).to have_content('We have emailed you your PDF')
  end
end
