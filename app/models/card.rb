class Card < ApplicationRecord
  has_many :board_cards
  has_many :boards, through: :board_cards

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
