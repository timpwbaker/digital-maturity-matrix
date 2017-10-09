class SubmissionsAggregator

  attr_reader :submissions, :areas, :score_map

  def initialize(submissions:, areas:, score_map:)
    @submissions = submissions
    @areas = areas
    @score_map = score_map
  end

  def current_averages_hash
    averages_hash(:current)
  end

  def target_averages_hash
    averages_hash(:target)
  end

  def current_averages_array
    averages_array(:current)
  end

  def target_averages_array
    averages_array(:target)
  end

  def current_average_maturity
    average_maturity(:current)
  end

  def target_average_maturity
    average_maturity(:target)
  end

  private

  def averages_hash(state)
    Hash[areas.map{|area|
      [area,
      submissions.inject(0){ |sum, submission|
        sum + submission.calculator.full_hash[state][area]
      }/count]
    }]
  end

  def averages_array(state)
    areas.map{ |area|
      averages_hash(state)[area]
    }
  end

  def average_maturity(state)
    (averages_array(state).reduce(:+).to_f/areas.count).round(0)
  end

  def count
    @_count ||= submissions.count
  end
end
