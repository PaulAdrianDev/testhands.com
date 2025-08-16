FactoryBot.define do
  factory :board do
    deck_summons { 3 }
    hand_summons { 3 }
    gy_banishment_summons { 3 }
    association :deck
    association :board_type
  end
end
