FactoryBot.define do
  factory :card do
    name { "Monster Card" }
    description { "Monster Card Description" }
    card_type { "dragon" }
    type { "MonsterCard" }
  end

  factory :monster_card do
    name { "Monster Card" }
    description { "Monster Card Description" }
    card_type { "dragon" }
    type { "MonsterCard" }
  end

  factory :spell_card do
    name { "Spell Card" }
    description { "Spell Card Description" }
    card_type { "normal" }
    type { "SpellCard" }
  end

  factory :trap_card do
    name { "Trap Card" }
    description { "Trap Card Description" }
    card_type { "normal" }
    type { "Trap Card" }
  end
end
