require 'rails_helper'

feature 'Create brand', :devise do
  scenario 'successfully create a brand' do
    user = FactoryGirl.create :user
    submission = FactoryGirl.create :submission, user: user

    signin(user.email, user.password)
    visit matrix_submission_path(submission.matrix, submission)
    click_link "Add your brand colours"
    click_button "Save"

    expect(page).to have_content "Color a can't be blank"

    fill_in 'brand_color_a', with: '#381634'
    fill_in 'brand_color_b', with: '#000000'
    click_button "Save"

    expect(page).to have_content('Brand was successfully created')

    click_link "Edit brand colours"

    fill_in 'brand_color_a', with: '#381634'
    fill_in 'brand_color_b', with: '#000000'
    click_button "Save"

    expect(page).to have_content('Brand was successfully updated')
  end
end
