namespace :convert_answers_and_targets do
  desc "converts the answers and targets relational db attributes to hash on submission"
  task to_json: :environment do
    Submission.all.each do |submission|
      submission.answers_json = Hash[Matrix.digital_maturity_areas.map{ |area| 
        [area,  Hash[submission.matrix.questions.where("area = ?", area).map{|question| 
          [question.id.to_s, submission.answers.find_by_question_id(question.id).choice] }]]
      }]
      submission.targets_json = Hash[Matrix.digital_maturity_areas.map{ |area| 
        [area,  Hash[submission.matrix.questions.where("area = ?", area).map{|question| 
          [question.id.to_s, submission.targets.find_by_question_id(question.id).choice] }]]
      }]
      submission.save
    end
  end
end
