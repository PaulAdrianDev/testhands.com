class Card < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
