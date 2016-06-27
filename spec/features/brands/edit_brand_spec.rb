require 'rails_helper'

feature 'Edit a brand', :devise do
  scenario 'successfully edit a brand' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_matrix_submission_path(1)
    page.find('#submit-button').click
    expect(page).to have_content('Created by:')
    page.find('#add-brand-colours').click
    fill_in 'brand_color_a', with: '#381634'
    fill_in 'brand_color_b', with: '#000000'
    page.find('#save-brand').click
    expect(page).to have_content('Brand was successfully created')
    page.find('#edit-brand-colours').click
    fill_in 'brand_color_a', with: '#381634'
    fill_in 'brand_color_b', with: '#000000'
    page.find('#save-brand').click
    expect(page).to have_content('Brand was successfully updated')
  end
end
