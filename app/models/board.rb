class Board < ApplicationRecord
  belongs_to :deck
  belongs_to :board_type

  validates :extra_deck_summons, presence: true
  validates :extra_deck_summons, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :hand_summons, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :gy_banishment_summons, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
