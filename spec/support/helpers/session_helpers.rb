module Features
  module SessionHelpers
    def sign_up_with(name, email, password, confirmation, org, turnover, size, digi)
      visit new_user_registration_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
      fill_in 'user[organisation]', with: org
      select(turnover, from: 'user[organisation_turnover]')
      select(size, from: 'user[organisation_size]')
      select(digi, from: 'user[digital_size]')
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
