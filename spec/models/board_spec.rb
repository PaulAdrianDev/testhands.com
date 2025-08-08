require 'rails_helper'

RSpec.describe Board, type: :model do
  subject(:board){ build(:board) }

  context "when extra_deck_summons" do
    context "is less than 0" do
      before { board.extra_deck_summons = -2}

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:extra_deck_summons]).to include("must be greater than or equal to 0")
      end
    end
  end

  context "when hand_summons" do
    context "is less than 0" do
      before { board.hand_summons = -2}

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:hand_summons]).to include("must be greater than or equal to 0")
      end
    end
  end

context "when gy_banishment_summons" do
  context "is less than 0" do
      before { board.gy_banishment_summons = -2}

      it "is invalid" do
        expect(board).to be_invalid
        expect(board.errors[:gy_banishment_summons]).to include("must be greater than or equal to 0")
      end
    end
  end
end
