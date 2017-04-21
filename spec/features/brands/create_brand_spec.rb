require 'rails_helper'

feature 'Create brand', :devise do
  scenario 'successfully create a brand' do
    user = FactoryGirl.create(:user)
    matrix = FactoryGirl.create(:matrix)
    signin(user.email, user.password)
    visit new_matrix_submission_path(matrix)
    page.find('#submit-button').click
    expect(page).to have_content('Created by:')
    page.find('#add-brand-colours').click
    fill_in 'brand_color_a', with: '#381634'
    fill_in 'brand_color_b', with: '#000000'
    page.find('#save-brand').click
    expect(page).to have_content('Brand was successfully created')
  end
end
