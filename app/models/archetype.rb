class Archetype < ApplicationRecord
  validates :name, presence: true

  has_many :deck_archetypes
  has_many :decks, through: :deck_archetypes
end
