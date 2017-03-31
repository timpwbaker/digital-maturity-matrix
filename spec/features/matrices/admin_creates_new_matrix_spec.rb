require 'spec_helper'

RSpec.feature "Managing a matrix" do
  scenario "Admin creates a new matrix" do
    admin = create :user, :admin

    signin(admin.email, admin.password)
    visit new_matrix_path
    fill_in 'Name', with: 'New Matrix'
    click_button 'Create Matrix'

    expect(page).to have_content 'Matrix was successfully created.'
  end

  scenario "Admin edits a matrix" do
    admin = create :user, :admin
    matrix = create :matrix, name: "Nebuchadnezzar"

    signin(admin.email, admin.password)
    visit edit_matrix_path(matrix)
    fill_in 'Name', with: 'Neo'
    click_button 'Update Matrix'

    expect(page).to have_content 'Name: Neo'
  end

  scenario "Admin adds a question" do
    admin = create :user, :admin
    matrix = create :matrix, name: "Nebuchadnezzar"

    signin(admin.email, admin.password)
    visit matrix_path(matrix)
    click_link 'Add Question'
    fill_in 'Body', with: "Do you Charles?"
    click_button 'Create Question'

    expect(page).to have_content 'Question was successfully created.'
    expect(page).to have_content 'Do you Charles?'
  end

  scenario "Admin edits a question" do
    admin = create :user, :admin
    matrix = create :matrix, name: 'Nebuchadnezzar'
    create :question, matrix: matrix, body: 'Do you love someone else?'

    signin(admin.email, admin.password)
    visit matrix_path(matrix)
    click_link 'Edit question', match: :first
    fill_in 'Body', with: "Do you Charles?"
    click_button 'Update Question'

    expect(page).to have_content 'Question was successfully updated'
    expect(page).to have_content 'Do you Charles?'
  end

  scenario "Admin deletes a question" do
    admin = create :user, :admin
    matrix = create :matrix, name: 'Nebuchadnezzar'
    create :question, matrix: matrix, body: 'Do you love someone else?'

    signin(admin.email, admin.password)
    visit matrix_path(matrix)
    click_link 'Delete', match: :first

    expect(page).to have_content 'Question was successfully destroyed'
  end
end
