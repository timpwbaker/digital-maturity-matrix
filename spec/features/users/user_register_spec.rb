require 'rails_helper'

feature 'Register', :devise do
  it 'user can register with valid details' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'user_organisation', with: 'Bob\'s Organisation'
    select 'Extra Small <£10,000', from: 'user_organisation_turnover'
    select '6-15', from: 'user_organisation_size'
    select '1', from: 'user_digital_size'
    click_button 'create-account'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

feature "User fails to register", :devise do
  it 'user can\'t register when passwords don\'t match' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password1'
    fill_in 'user_organisation', with: 'Bob\'s Organisation'
    select 'Extra Small <£10,000', from: 'user_organisation_turnover'
    select '6-15', from: 'user_organisation_size'
    select '1', from: 'user_digital_size'
    click_button 'create-account'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

  it 'user can\'t register when password is too short' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: 'bob@example.com'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    fill_in 'user_organisation', with: 'Bob\'s Organisation'
    select 'Extra Small <£10,000', from: 'user_organisation_turnover'
    select '6-15', from: 'user_organisation_size'
    select '1', from: 'user_digital_size'
    click_button 'create-account'
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
  end

  it 'user can\'t register with an email address that already exists' do
    user = FactoryGirl.create(:user)
    visit new_user_registration_path
    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'pass'
    fill_in 'user_organisation', with: 'Bob\'s Organisation'
    select 'Extra Small <£10,000', from: 'user_organisation_turnover'
    select '6-15', from: 'user_organisation_size'
    select '1', from: 'user_digital_size'
    click_button 'create-account'
    expect(page).to have_content 'Email has already been taken'
  end
end
