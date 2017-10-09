require "rails_helper"

RSpec.describe SubmissionsAggregator, ".new" do
  it "initializes with submissions, areas and score map" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.submissions).to eq submissions
    expect(aggregator.areas).to be areas
    expect(aggregator.score_map).to be score_map
  end
end

RSpec.describe SubmissionsAggregator, "#current_averages_hash" do
  it "returns a hash of current averages by area" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.current_averages_hash).to eq(
      {
        "Technology"=>100,
        "Channels & Devices"=>100,
        "Audiences"=>100,
        "User Experience"=>100,
        "Content"=>100,
        "Campaigns"=>100,
        "Analytics"=>100,
        "Governance"=>100
      }
    )
  end
end

RSpec.describe SubmissionsAggregator, "#target_averages_hash" do
  it "returns a hash of current averages by area" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.target_averages_hash).to eq(
      {
        "Technology"=>100,
        "Channels & Devices"=>100,
        "Audiences"=>100,
        "User Experience"=>100,
        "Content"=>100,
        "Campaigns"=>100,
        "Analytics"=>100,
        "Governance"=>100
      }
    )
  end
end

RSpec.describe SubmissionsAggregator, "#current_averages_array" do
  it "returns an array of the current averages, one for each area" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.current_averages_array).to eq(
      [100, 100, 100, 100, 100, 100, 100, 100]
    )
  end
end

RSpec.describe SubmissionsAggregator, "#target_averages_array" do
  it "returns an array of the current averages, one for each area" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.current_averages_array).to eq(
      [100, 100, 100, 100, 100, 100, 100, 100]
    )
  end
end

RSpec.describe SubmissionsAggregator, "#current_average_maturity" do
  it "returns an integer for the overall current maturity for supplied submissions" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.current_average_maturity).to eq 100
  end
end

RSpec.describe SubmissionsAggregator, "#target_average_maturity" do
  it "returns an integer for the overall current maturity for supplied submissions" do
    submissions = FactoryGirl.create_list :submission, 3
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    aggregator = SubmissionsAggregator.new(
      submissions: submissions, areas: areas, score_map: score_map
    )

    expect(aggregator.target_average_maturity).to eq 100
  end
end
