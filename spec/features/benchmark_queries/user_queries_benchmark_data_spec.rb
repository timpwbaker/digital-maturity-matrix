require 'rails_helper'

RSpec.feature 'User queries benchmarking data' do
  it 'returns benchmarked data' do
    matrix = create :matrix
    10.times do |thing|
      user = create :user, organisation_size: '1-5'
      create :submission, user: user, matrix: matrix
    end
    user = create :user

    signin(user.email, user.password)
    visit new_benchmark_query_path
    select '1-5', from: 'query_organisation_size'
    click_button 'submit'

    expect(page).to have_content "Current average maturity: 100%"
  end

  it 'returns no data and a reason' do
    matrix = create :matrix
    5.times do |thing|
      user = create :user, organisation_size: '1-5'
      create :submission, user: user, matrix: matrix
    end
    user = create :user

    signin(user.email, user.password)
    visit new_benchmark_query_path
    select '1-5', from: 'query_organisation_size'
    click_button 'submit'

    expect(page).to have_content "Sorry there's not enough data, try widening your search"
  end
end
