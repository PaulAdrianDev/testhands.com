class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  
  has_many :board_cards
end