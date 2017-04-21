FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
    organisation 'Org'
    organisation_turnover 'Extra Small <£10,000'
    organisation_size '1-5'
    digital_size '21-30'

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

    after(:create) do |submission|
      submission.matrix.questions.each do |question|
        submission.answers << create(:answer, question: question, question_answered: question.body)
        submission.targets << create(:target, question: question, question_answered: question.body)
      end
    end
  end

  factory :answer do
    choice "Strongly agree"
    score 16.6666666666667
  end

  factory :target do
    choice "Strongly agree"
    score 16.6666666666667
  end
end
