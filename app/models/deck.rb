class Deck < ApplicationRecord
  belongs_to :user
  validates :tier, inclusion: { in: [ 1, 2, 3, 4, 5 ] }

  has_many :boards
  has_many :deck_archetypes
  has_many :archetypes, through: :deck_archetypes

  def name
    archetype_list = archetypes.map(&:name).join(" ")
    if archetype_list.empty?
      "New Deck"
    else
      archetype_list
    end
  end
  
  scope :with_includes, -> {
    includes(:user, :archetypes, boards: [ :board_type, { board_cards: :card } ])
  }

  scope :with_tier, ->(tier) {
    return all if tier.blank? || tier == "any"
    where(tier: tier.to_i)
  }

  scope :with_archetype_id, ->(id) {
    if id.is_a?(Integer)
      joins(:archetypes).where(archetypes: { id: id })
    else
      all
    end
  }
end
