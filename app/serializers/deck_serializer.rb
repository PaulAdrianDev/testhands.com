class DeckSerializer < ActiveModel::Serializer
  attributes :id, :tier, :advice
  belongs_to :user
  
  has_many :archetypes
  has_many :boards
end