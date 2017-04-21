require 'rails_helper'

RSpec.describe 'user makes a benchmark query' do
  context 'querying on organisation size' do
    it 'returns the average of the results' do
      matrix = create :matrix
      10.times do |thing|
        user = create :user, organisation_size: '1-5'
        submission = create :submission, user: user, matrix: matrix
      end
      post(query_path(api_key: User.first.api_key, query: { organisation_size: '1-5' }, format: :json))
      expect(JSON.parse(response.body)).to eq ({"average_current_maturity"=>{"Technology"=>0, "Channels & Devices"=>0, "Audiences"=>0, "User Experience"=>0, "Content"=>0, "Campaigns"=>0, "Analytics"=>0, "Governance"=>0}, "average_target_maturity"=>{"Technology"=>0, "Channels & Devices"=>0, "Audiences"=>0, "User Experience"=>0, "Content"=>0, "Campaigns"=>0, "Analytics"=>0, "Governance"=>0}, "current_submissions_array"=>[0, 0, 0, 0, 0, 0, 0, 0], "target_submissions_array"=>[0, 0, 0, 0, 0, 0, 0, 0]})
    end
  end
end
