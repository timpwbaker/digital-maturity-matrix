require 'rails_helper'

feature 'Email submission', :devise do

  scenario 'Email a submission' do
  	user = FactoryGirl.create(:user)
    signin(user.email, user.password)
  	visit new_matrix_submission_path(1)
  	page.find('#submit-button').click
  	expect(page).to have_content('Created by:')
  	visit submissions_emailpdf_path(Matrix.find(1).id,Submission.find_by_user_id(user.id))
  	expect(Delayed::Job.count).to eq(1)
  end

end
