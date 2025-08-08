require 'rails_helper'

RSpec.describe BoardCard, type: :model do
  subject(:board_card) { build(:board_card) }

  context "when the position" do
    context "is not within the allowed values" do
      it "is invalid" do
        valid_zones = %w[ mmz1 mmz2 mmz3 mmz4 mmz5 stz1 stz2 stz3 stz4 stz5 emz1 emz2 field graveyard banishment deck extra_deck ]

        valid_zones.each do |zone|
          board_card.position = zone
          expect(board_card).to be_valid
        end
      end
    end
  end
end
