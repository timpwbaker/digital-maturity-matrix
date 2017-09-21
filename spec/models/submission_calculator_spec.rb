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

RSpec.describe SubmissionCalculator, "#top_line_current" do
  it "returns an integer denoting top line maturity" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.top_line_current).to eq 100
  end
end

RSpec.describe SubmissionCalculator, "#top_line_target" do
  it "returns an integer denoting top line maturity" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.top_line_target).to eq 100
  end
end

RSpec.describe SubmissionCalculator, "#total_current_score_by(area)" do
  it "returns an integer the top line score for a particular area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    areas.each do |area|
      expect(calculator.total_current_score_by(area)).to eq 100
    end
  end
end

RSpec.describe SubmissionCalculator, "#total_target_score_by(area)" do
  it "returns an integer the top line score for a particular area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    areas.each do |area|
      expect(calculator.total_target_score_by(area)).to eq 100
    end
  end
end

RSpec.describe SubmissionCalculator, "#current_data_array" do
  it "returns an array of current scores for each area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.current_data_array)
      .to eq [100, 100, 100, 100, 100, 100, 100, 100]
  end
end

RSpec.describe SubmissionCalculator, "#current_data_array" do
  it "returns an array of target scores for each area" do
    submission = FactoryGirl.create :submission
    areas = Matrix.digital_maturity_areas
    score_map = Submission.score_map
    calculator = SubmissionCalculator.new(
      submission: submission, areas: areas, score_map: score_map
    )

    expect(calculator.current_data_array)
      .to eq [100, 100, 100, 100, 100, 100, 100, 100]
  end
end
