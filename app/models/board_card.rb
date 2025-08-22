class BoardCard < ApplicationRecord
  belongs_to :board
  belongs_to :card

  validates :position, inclusion: { in: %w[ mmz1 mmz2 mmz3 mmz4 mmz5 stz1 stz2 stz3 stz4 stz5 emz1 emz2 field graveyard banishment deck extra_deck hand ] }
end
