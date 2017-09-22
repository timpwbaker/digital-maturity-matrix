require 'rails_helper'

feature 'Edit submission', :devise do
  scenario 'edits a submission' do
    submission = create :submission

    signin(submission.user.email, submission.user.password)
    visit edit_matrix_submission_path(submission.matrix, submission)

    page.select("Agree", :from => "submission_answers_json_Technology_#{submission.matrix.questions.first.id}")
    page.find('#submit-button').click

    expect(page).to have_content('Current digital maturity: 99%')
    expect(page).to have_content('Current: 94%')
  end
end
