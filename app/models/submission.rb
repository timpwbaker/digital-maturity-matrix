class Submission < ActiveRecord::Base
  belongs_to :matrix
  belongs_to :user
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                                allow_destroy: true
  has_many :targets, dependent: :destroy
  accepts_nested_attributes_for :targets,
                                allow_destroy: true
  

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

  def self.to_csv(object)
    require 'csv'
    CSV.generate do |csv|
      headers = ["Submission ID"]
      Question.all.each do |question|
        headers << "current: #{question.body}"
        headers << "target: #{question.body}"
      end
      csv << headers
      object.each do |submission|
        row = []
        row << submission.id
        submission.answers.each_with_index do |answer, index|
          row << answer.choice
        end
        submission.targets.each_with_index do |target, index|
          row << target.choice
        end
        csv << row
      end
    end
  end

    private

   
  def name
    "#{first_name} #{last_name}"
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
