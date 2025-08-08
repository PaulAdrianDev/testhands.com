FactoryBot.define do
  factory :deck do
    power_level { 2 }
    association :user
  end
end
