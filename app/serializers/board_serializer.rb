class BoardSerializer < ActiveModel::Serializer
  attributes :id, :deck_summons, :hand_summons, :gy_banishment_summons

  belongs_to :deck
  belongs_to :board_type
  has_many :board_cards  # exposes position + nested card
end