class SubmissionCalculator

  attr_reader :submission, :areas, :score_map

  def initialize(submission:, areas:, score_map:)
    @submission = submission
    @areas = areas
    @score_map = score_map
  end

  def total_current_score_by(area)
    submission.answers_json[area]
      .inject(0){ |sum, (_, value)| sum + score_map[value.to_sym] }
      .round(0)
  end

  def total_target_score_by(area)
    submission.targets_json[area]
      .inject(0){ |sum, (_, value)| sum + score_map[value.to_sym] }
      .round(0)
  end

  def current_data_array
    areas.map{|area|
      total_current_score_by(area)
    }
  end

  def target_data_array
    areas.map{|area|
      total_target_score_by(area)
    }
  end

  def top_line_current
    current_data_array.reduce(:+)/areas.count
  end

  def top_line_target
    target_data_array.reduce(:+)/areas.count
  end
end
