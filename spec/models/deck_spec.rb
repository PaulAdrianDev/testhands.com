require 'rails_helper'

RSpec.describe Deck, type: :model do
  context "when the power level is" do
    subject(:deck) { build(:deck)}

    context "less than 1" do
      before{ deck.power_level = 0 } 

      it "is invalid" do
        expect(deck).to be_invalid
        expect(deck.errors[:power_level]).to include("is not included in the list")
      end
    end

    context "more than 5" do
      before{ deck.power_level = 6 } 

      it "is invalid" do
        expect(deck).to be_invalid
        expect(deck.errors[:power_level]).to include("is not included in the list")
      end
    end

    context "within 1-5" do
      it "is valid" do
        [ 1, 2, 3, 4, 5 ].each do |level|
          deck.power_level = level
          expect(deck).to be_valid
        end
      end
    end

    context "blank" do
      before{ deck.power_level = "" } 

      it "is invalid" do
        expect(deck).to be_invalid
        expect(deck.errors[:power_level]).to include("is not included in the list")
      end
    end

    context "nil" do
      before{ deck.power_level = nil } 

      it "is invalid" do
        expect(deck).to be_invalid
        expect(deck.errors[:power_level]).to include("is not included in the list")
      end
    end
  end
end
