class Deck < ApplicationRecord
  belongs_to :user
  validates :tier, inclusion: { in: [ 1, 2, 3, 4, 5 ] }

  has_many :boards
  has_many :deck_archetypes
  has_many :archetypes, through: :deck_archetypes

  scope :with_includes, -> {
    includes(:user, :archetypes, boards: [:board_type, { board_cards: :card }])
  }

  scope :with_tier, ->(tier) {
    return all if tier.blank? || tier == "any"
    where(tier: tier.to_i)
  }
end
