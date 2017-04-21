class Submission < ActiveRecord::Base
  belongs_to :matrix
  belongs_to :user
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                                allow_destroy: true
  has_many :targets, dependent: :destroy
  accepts_nested_attributes_for :targets,
                                allow_destroy: true

  before_save :update_top_line_current
  before_save :update_top_line_target

  def self.choices
    [
      'Strongly Agree',
      'Agree',
      'Disagree',
      'Strongly Disagree'
    ]
  end

  def self.add_attachment
    has_attached_file :export
    validates_attachment :export, content_type: { content_type: ["application/pdf"] }
  end

  def self.to_csv(submissions)
    require 'csv'
    CSV.generate do |csv|
      headers = ["Submission ID", "User name", "User organisation", "Organisation size", "Organisation turnover", "Digital team size", "Marketing opt in"]
      Matrix.digital_maturity_areas.each_with_index do |area, index|
        Question.where("area = '#{area}'").each do |question|
          headers << "current: #{area} // #{question.body}"
          headers << "target: #{area} // #{question.body}"
        end
      end
      csv << headers
      submissions.each do |submission|
        row = []
        row << submission.id
        row << submission.user.name
        row << submission.user.organisation
        row << submission.user.organisation_size
        row << submission.user.organisation_turnover
        row << submission.user.digital_size
        row << submission.user.opt_in
        Matrix.digital_maturity_areas.each_with_index do |area, index|
          Question.where(matrix: submission.matrix).where("area = '#{area}'").each do |question|
            answer = Answer.where("submission_id = '#{submission.id}'").where("question_id = '#{question.id}'").first
            target = Target.where("submission_id = '#{submission.id}'").where("question_id = '#{question.id}'").first
            row << "#{answer.score}"
            row << "#{target.score}"
          end
        end
        csv << row
      end
    end
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

  after_save :update_scores

  def update_scores
    answers.each do |answer|
      @answer = Answer.find(answer.id)
      if answer.choice == 'Strongly Agree'
        @answer.update_column(:score, 16.666666666666666666)
      elsif answer.choice == 'Agree'
        @answer.update_column(:score, 11)
      elsif answer.choice == 'Disagree'
        @answer.update_column(:score, 6)
      elsif answer.choice == 'Strongly Disagree'
        @answer.update_column(:score, 0)
           end
    end
    targets.each do |target|
      @target = Target.find(target.id)
      if target.choice == 'Strongly Agree'
        @target.update_column(:score, 16.666666666666666666)
      elsif target.choice == 'Agree'
        @target.update_column(:score, 11)
      elsif target.choice == 'Disagree'
        @target.update_column(:score, 6)
      elsif target.choice == 'Strongly Disagree'
        @target.update_column(:score, 0)
      end
    end
  end
end
