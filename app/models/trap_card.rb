class TrapCard < Card
  validates :card_type, inclusion: { in: %w[ normal continuous counter ] }
end