class Deck < ApplicationRecord
  belongs_to :user
  validates :tier, inclusion: { in: [ 1, 2, 3, 4, 5 ] }

  has_many :deck_archetypes
  has_many :archetypes, through: :deck_archetypes
end
