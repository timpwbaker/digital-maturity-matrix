# Feature: Register
#   As a user
#   I want to Register
#   So I can access the create my matrix area of the site
feature 'Register', :devise do
  # Scenario: User can create an account with valid details
  #   Given I do not exist as a user
  #   When I register with valid details
  #   I am registered and see a confirmation message
  scenario 'user can register with valid details' do
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

  # Scenario: User can't register with passwords that don't match
  #   As a user
  #   When I try to register with passwords that don't match
  #   I see an error telling me what's wrong
  scenario 'user can\'t register when passwords don\'t match' do
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

  # Scenario: User can't register with passwords that are too short
  #   As a user
  #   When I try to register with a password that is too short
  #   I see an error telling me what's wrong
  scenario 'user can\'t register when password is too short' do
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

  # Scenario: User can't register with passwords that don't match
  #   As a user
  #   When I try to register with an email address that already exists
  #   I see an error telling me what's wrong
  scenario 'user can\'t register with an email address that already exists' do
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
