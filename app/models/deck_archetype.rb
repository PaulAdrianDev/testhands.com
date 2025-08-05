class DeckArchetype < ApplicationRecord
  belongs_to :deck
  belongs_to :archetype

  belongs_to :board
  belongs_to :card
end
