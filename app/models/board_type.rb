class BoardType < ApplicationRecord
  TYPES = [ "Full Combo 1", "Full Combo 2", "Interrupted Once", "Interrupted Twice", "Interrupted 3+ Times", "Through Fuwalos", "Through Purulia", "Through Meowls", "Through Droll", "Through Nibiru" ].freeze

  validates :name, presence: true, inclusion: { in: TYPES }
end
