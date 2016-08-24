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
      headers = ["Submission ID", "User name", "User organisation", "Organisation size", "Organisation turnover", "Digital team size", "Marketing opt in"]
      Matrix.digital_maturity_areas.each_with_index do |area, index|
        Question.where("area = '#{area}'").each do |question|
          headers << "current: #{area} // #{question.body}"
          headers << "target: #{area} // #{question.body}"
        end
      end
      csv << headers
      object.each do |submission|
        row = []
        row << submission.id
        row << submission.user.name
        row << submission.user.organisation
        row << submission.user.organisation_size
        row << submission.user.organisation_turnover
        row << submission.user.digital_size
        row << submission.user.opt_in
        Matrix.digital_maturity_areas.each_with_index do |area, index|
          Question.where("area = '#{area}'").each do |question|
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
