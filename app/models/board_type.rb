class BoardType < ApplicationRecord
  validates :name, presence: true # Will add IS IN constraint after
end
