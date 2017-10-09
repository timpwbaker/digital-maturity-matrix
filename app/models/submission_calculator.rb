class SubmissionCalculator

  attr_reader :submission, :areas, :score_map

  def initialize(submission:, areas:, score_map:)
    @submission = submission
    @areas = areas
    @score_map = score_map
  end

  def current_maturity
    top_line(submission.answers_json)
  end

  def target_maturity
    top_line(submission.targets_json)
  end

  def current_hash
    averages_hash(submission.answers_json)
  end

  def target_hash
    averages_hash(submission.targets_json)
  end

  def full_hash
    {current: current_hash, target: target_hash}
  end

  def current_array
    data_array_for(submission.answers_json)
  end

  def target_array
    data_array_for(submission.targets_json)
  end

  private

  def averages_hash(json)
    Hash[areas.map{
      |area| [area, total_score_by(area, json)]
    }]
  end

  def total_score_by(area, json)
    json[area]
      .inject(0){ |sum, (_, value)| sum + score_map[value.to_sym] }
      .round(0)
  end

  def data_array_for(json)
    areas.map{|area|
      total_score_by(area, json)
    }
  end

  def top_line(json)
    data_array_for(json).reduce(:+)/areas.count
  end

  # def top_line_target
  #   target_data_array.reduce(:+)/areas.count
  # end
  #
  # def total_current_score_by(area)
  #   submission.answers_json[area]
  #     .inject(0){ |sum, (_, value)| sum + score_map[value.to_sym] }
  #     .round(0)
  # end
  #
  # def total_target_score_by(area)
  #   submission.targets_json[area]
  #     .inject(0){ |sum, (_, value)| sum + score_map[value.to_sym] }
  #     .round(0)
  # end
  #
  # def current_data_array
  #   areas.map{|area|
  #     total_current_score_by(area)
  #   }
  # end
  #
  # def target_data_array
  #   areas.map{|area|
  #     total_target_score_by(area)
  #   }
  # end
  #
  # def top_line_current
  #   current_data_array.reduce(:+)/areas.count
  # end
  #
  # def top_line_target
  #   target_data_array.reduce(:+)/areas.count
  # end
end
