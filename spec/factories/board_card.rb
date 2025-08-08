FactoryBot.define do
  factory :board_card do
    position { "mmz1" }
    association :board
    association :card
  end
end