class SpellCard < Card
  validates :card_type, inclusion: { in: %w[ normal continuous equip quick-play field ritual ] }
end