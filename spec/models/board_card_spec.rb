require 'rails_helper'

RSpec.describe BoardCard, type: :model do
  subject(:user) { build(:user) }
  let!(:deck) { Deck.create!(power_level: 1, user: user) }
  let!(:board_type) { BoardType.create!(name: "Board Type") }
  let!(:board) { Board.create!(extra_deck_summons: 3, hand_summons: 3, gy_banishment_summons: 3, deck: deck, board_type: board_type) }
  let!(:card) { MonsterCard.create(name: "Card", description: "Desc", card_type: "dragon") }

  context "when the position" do
    context "is not within the allowed values" do
      it "is invalid" do
        valid_zones = %w[ mmz1 mmz2 mmz3 mmz4 mmz5 stz1 stz2 stz3 stz4 stz5 emz1 emz2 field graveyard banishment deck extra_deck ]
        valid_zones.each do |zone|
          board_card = BoardCard.new(board: board, card: card, position: zone)
          expect(board_card).to be_valid
        end
      end
    end
  end
end
