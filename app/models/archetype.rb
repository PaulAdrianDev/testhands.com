class Archetype < ApplicationRecord
  validates :name, presence: true # Will add IS IN constraint after

  has_many :deck_archetypes
  has_many :decks, through: :deck_archetypes
end
