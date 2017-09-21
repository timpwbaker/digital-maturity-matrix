class Submission < ActiveRecord::Base 
  belongs_to :matrix
  belongs_to :user

  # before_save :update_top_line_current
  # before_save :update_top_line_target

  def self.choices
    [
      'Strongly Agree',
      'Agree',
      'Disagree',
      'Strongly Disagree'
    ]
  end

  def self.for_users(users)
    where(user: users)
  end

  def self.add_attachment
    has_attached_file :export
    validates_attachment :export, content_type: { content_type: ["application/pdf"] }
  end

  def self.current_averages
    result = {}
    count = self.all.count
    submissions = self.all
    Matrix.digital_maturity_areas.each do |area|
      total_current = submissions.inject(0) { |total, submission| total = total + submission.top_line_current_hash[area].to_i }
      average_current = total_current/count
      result[area] = average_current
    end
    result
  end

  def self.target_averages
    result = {}
    count = self.all.count
    submissions = self.all
    Matrix.digital_maturity_areas.each do |area|
      total_targets = submissions.inject(0) { |total, submission| total = total + submission.top_line_target_hash[area].to_i }
      average_target = total_targets/count
      result[area] = average_target
    end
    result
  end

  def self.current_averages_array
    current_averages = self.current_averages
    Matrix.digital_maturity_areas.map{ |area|
      current_averages[area]
    }
  end

  def self.target_averages_array
    target_averages = self.target_averages
    Matrix.digital_maturity_areas.map{ |area|
      target_averages[area]
    }
  end

  def self.current_average_maturity
    self.current_averages_array.inject(:+).to_f/8
  end

  def self.target_average_maturity
    self.target_averages_array.inject(:+).to_f/8
  end

  def top_line_current
    (answers.sum('score') / Matrix.digital_maturity_areas.count).round(0)
  end

  def top_line_target
    (targets.sum('score') / Matrix.digital_maturity_areas.count).round(0)
  end

  def total_current_score_by(area)
    answers.joins(:question).where('questions.area = ?', area).inject(0) { |sum, answer| sum + answer.score }.round(0)
  end

  def total_target_score_by(area)
    targets.joins(:question).where('questions.area = ?', area).inject(0) { |sum, answer| sum + answer.score }.round(0)
  end

  def current_data_array
    Matrix.digital_maturity_areas.map{|area| self.total_current_score_by(area)}
  end

  def target_data_array
    Matrix.digital_maturity_areas.map{|area| self.total_target_score_by(area)}
  end

  def answers_ordered_by_question_area
    answers.joins(:question).order('questions.area').order('questions.id')
  end

  def targets_ordered_by_question_area
    targets.joins(:question).order('questions.area').order('questions.id')
  end

  private

  def update_top_line_current
    stats = {}
    Matrix.digital_maturity_areas.each do |area|
      stats[area.to_sym] = total_current_score_by(area)
    end
    self.top_line_current_hash = stats
  end

  def update_top_line_target
    stats = {}
    Matrix.digital_maturity_areas.each do |area|
      stats[area.to_sym] = total_target_score_by(area)
    end
    self.top_line_target_hash = stats
  end

  def name
    "#{user.name}"
  end
end
