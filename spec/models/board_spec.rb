require 'rails_helper'

RSpec.describe Board, type: :model do
  subject(:user) { build(:user) }
  subject(:deck) { build(:deck, user: user)}
  let(:board_type) { BoardType.create!(name: "Board Type") }

  let(:extra_deck_summons) { 3 }
  let(:hand_summons) { 3 }
  let(:gy_banishment_summons) { 3 }

  let(:board) do
    Board.new(
      extra_deck_summons: extra_deck_summons,
      hand_summons: hand_summons,
      gy_banishment_summons: gy_banishment_summons,
      deck_id: deck.id,
      board_type_id: board_type.id
    )
  end

  context "when extra_deck_summons" do
    context "is less than 0" do
      let(:extra_deck_summons) { -2 }

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:extra_deck_summons]).to include("must be greater than or equal to 0")
      end
    end
  end

  context "when hand_summons" do
    context "is less than 0" do
      let(:hand_summons) { -2 }

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:hand_summons]).to include("must be greater than or equal to 0")
      end
    end
  end

context "when gy_banishment_summons" do
  context "is less than 0" do
      let(:gy_banishment_summons) { -2 }

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:gy_banishment_summons]).to include("must be greater than or equal to 0")
      end
    end
  end
end
