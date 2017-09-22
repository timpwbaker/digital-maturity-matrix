class Submission < ActiveRecord::Base 
  belongs_to :matrix
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :targets, dependent: :destroy

  CHOICES = [
    'Strongly Agree',
    'Agree',
    'Disagree',
    'Strongly Disagree'
  ]

  SCORE_MAP = {
    "Strongly Agree": 16 + 2/3.to_f,
    "Agree": 11,
    "Disagree": 6,
    "Strongly Disagree": 0
  }

  def self.choices
    CHOICES
  end

  def self.score_map
    SCORE_MAP
  end

  def self.aggregator
    SubmissionsAggregator.new(submissions: self.all,
                              areas: Matrix.digital_maturity_areas,
                              score_map: Submission.score_map)
  end

  def calculator
    SubmissionCalculator.new(submission: self,
                             areas: Matrix.digital_maturity_areas,
                             score_map: Submission.score_map)
  end

  private

  def name
    "#{user.name}"
  end
end
