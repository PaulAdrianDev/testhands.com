class BoardSerializer < ActiveModel::Serializer
  attributes :id, :deck_summons, :hand_summons, :gy_banishment_summons
end
