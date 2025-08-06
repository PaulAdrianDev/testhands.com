class BoardCard < ApplicationRecord
  belongs_to :board
  belongs_to :card
end
