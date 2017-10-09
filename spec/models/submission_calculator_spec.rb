require "rails_helper"

RSpec.describe SubmissionCalculator, '.new' do
  it "initializes with a submission, areas and score map" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.submission).to be submission
    expect(calculator.areas).to be areas
    expect(calculator.score_map).to be score_map
 end
end

RSpec.describe SubmissionCalculator, "#current_maturity" do
  it "returns an integer denoting top line maturity" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.current_maturity).to eq 100
  end
end

RSpec.describe SubmissionCalculator, "#target_maturity" do
  it "returns an integer denoting top line maturity" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.target_maturity).to eq 100
  end
end

RSpec.describe SubmissionCalculator, "#current_hash" do
  it "returns a hash of areas and targets" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    areas.each do |area|
      expect(calculator.current_hash).to eq(
        {"Technology"=>100, "Channels & Devices"=>100,
         "Audiences"=>100, "User Experience"=>100, 
         "Content"=>100, "Campaigns"=>100, "Analytics"=>100, "Governance"=>100}
      )
    end
  end
end

RSpec.describe SubmissionCalculator, "#target_hash" do
  it "returns a hash of areas and targets" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    areas.each do |area|
      expect(calculator.target_hash).to eq(
        {"Technology"=>100, "Channels & Devices"=>100,
         "Audiences"=>100, "User Experience"=>100, 
         "Content"=>100, "Campaigns"=>100, "Analytics"=>100, "Governance"=>100}
      )
    end
  end
end

RSpec.describe SubmissionCalculator, "#current_array" do
  it "returns an array of current scores for each area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.current_array)
      .to eq [100, 100, 100, 100, 100, 100, 100, 100]
  end
end

RSpec.describe SubmissionCalculator, "#target_array" do
  it "returns an array of target scores for each area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.target_array)
      .to eq [100, 100, 100, 100, 100, 100, 100, 100]
  end
end
