class BoardCardSerializer < ActiveModel::Serializer
  attributes :id, :position
  
  belongs_to :board
  belongs_to :card
end