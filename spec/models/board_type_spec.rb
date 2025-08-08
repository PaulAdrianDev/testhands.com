require 'rails_helper'

RSpec.describe BoardType, type: :model do
  subject(:board_type){ build(:board_type) }

  context "when the name is" do
    context "blank" do
      it "is invalid" do
        board_type.name = ""

        expect(board_type).to be_invalid
      end
    end

    context "nil" do
      it "is invalid" do
        board_type.name = nil

        expect(board_type).to be_invalid
      end
    end
  end
end
