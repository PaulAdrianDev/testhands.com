class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :card_type, :type
  
  has_many :board_cards
end