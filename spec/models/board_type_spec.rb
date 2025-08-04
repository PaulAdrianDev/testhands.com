require 'rails_helper'

RSpec.describe BoardType, type: :model do
  context "when the name is" do
    context "blank" do
      it "is invalid" do
        board_type = BoardType.new(name: "")

        expect(board_type).to be_invalid
      end
    end

    context "nil" do
      it "is invalid" do
        board_type = BoardType.new(name: nil)

        expect(board_type).to be_invalid
      end
    end
  end
end
