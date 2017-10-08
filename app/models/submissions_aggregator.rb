class SubmissionsAggregator

  attr_reader :submissions, :areas, :score_map

  def initialize(submissions:, areas:, score_map:)
    @submissions = submissions
    @areas = areas
    @score_map = score_map
  end

  def current_averages
    Hash[areas.map{|area|
      [area,
      submissions.inject(0){ |sum, submission|
        sum + total_current_score_for(submission, area)
      }/count]
    }]
  end

  def target_averages
    Hash[areas.map{|area|
      [area,
      submissions.inject(0){ |sum, submission|
        sum + total_target_score_for(submission, area)
      }/count]
    }]
  end

  def current_averages_array
    areas.map{ |area|
      current_averages[area]
    }
  end

  def target_averages_array
    areas.map{ |area|
      target_averages[area]
    }
  end

  def current_average_maturity
    (current_averages_array.reduce(:+).to_f/areas.count).round(0)
  end

  def target_average_maturity
    (target_averages_array.reduce(:+).to_f/areas.count).round(0)
  end

  private

  def total_current_score_for(submission, area)
    submission.calculator.total_current_score_by(area)
  end

  def total_target_score_for(submission, area)
    submission.calculator.total_target_score_by(area)
  end

  def count
    @_count ||= submissions.count
  end
end
