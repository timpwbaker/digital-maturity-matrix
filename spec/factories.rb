FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) { |n| "email#{n}@email.com" }
    password 'please123'
    organisation 'Org'
    organisation_turnover 'Extra Small <£10,000'
    organisation_size '1-5'
    digital_size '21-30'
    api_key SecureRandom.uuid

    trait :admin do
      admin true
    end
  end

  factory :matrix do
    name "Digital Maturity Matrix"

    after(:create) do |matrix|
      Matrix.digital_maturity_areas.each do |area|
        matrix.questions << [create_list(:question, 6, matrix: matrix, area: area)]
      end
    end
  end

  factory :question do
    matrix
    body "What do you mean?"
    area "Technology"
  end

  factory :submission do
    matrix
    user

    after(:create) { |instance|
      instance.answers_json = Hash[Matrix.digital_maturity_areas.map{ |area| 
        [area,  Hash[instance.matrix.questions.where("area = ?", area).map{|question| 
          [question.id.to_s, "Strongly Agree"] }]]
      }]
      instance.targets_json = Hash[Matrix.digital_maturity_areas.map{ |area| 
        [area,  Hash[instance.matrix.questions.where("area = ?", area).map{|question| 
          [question.id.to_s, "Strongly Agree"] }]]
      }]
      instance.save
    }
  end
end
