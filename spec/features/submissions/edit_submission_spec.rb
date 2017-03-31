require 'rails_helper'

feature 'Edit submission', :devise do
  scenario 'edits a submission' do
    submission = create :submission

    signin(submission.user.email, submission.user.password)
    visit edit_matrix_submission_path(submission.matrix, submission)

    page.select("Agree", :from => "question_answer_#{submission.answers.first.id}")
    page.find('#submit-button').click
    save_and_open_page

    expect(page).to have_content('Current digital maturity: 99%')
    expect(page).to have_content('Current: 94%')
  end
end
