FactoryBot.define do
  factory :deck do
    tier { 2 }
    association :user
  end
end
