FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'test@example.com'
    password 'please123'
    organisation 'Org'
    organisation_turnover 'Extra Small <£10,000'
    organisation_size '1-5'
    digital_size '21-30'
  end
end
