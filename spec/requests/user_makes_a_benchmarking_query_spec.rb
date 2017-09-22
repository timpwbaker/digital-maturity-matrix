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
      expect(JSON.parse(response.body)).to eq (
        {
          "average_current_maturity"=>{
            "Technology"=>100,
            "Channels & Devices"=>100,
            "Audiences"=>100,
            "User Experience"=>100,
            "Content"=>100,
            "Campaigns"=>100,
            "Analytics"=>100,
            "Governance"=>100
          },
          "average_target_maturity"=>{
            "Technology"=>100,
            "Channels & Devices"=>100,
            "Audiences"=>100,
            "User Experience"=>100,
            "Content"=>100,
            "Campaigns"=>100,
            "Analytics"=>100,
            "Governance"=>100
          },
          "current_submissions_array"=>[100, 100, 100, 100, 100, 100, 100, 100],
          "target_submissions_array"=>[100, 100, 100, 100, 100, 100, 100, 100]
        }
      )
    end
  end
end
