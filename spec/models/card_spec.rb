require 'rails_helper'

RSpec.describe Card, type: :model do
  subject(:card) { create(:monster_card) }

  context "when the data is correct" do
    it "is valid" do
      expect(card).to be_valid
    end
  end

  context "when the name" do
    context "is duplicate of another card" do
      it "is invalid regardless of type" do
        card

        monstercard = build(:monster_card)
        spellcard = build(:spell_card, name: card.name)
        trapcard = build(:trap_card, name: card.name)

        expect(monstercard).to be_invalid
        expect(spellcard).to be_invalid
        expect(trapcard).to be_invalid

        expect(monstercard.errors[:name]).to include("has already been taken")
        expect(spellcard.errors[:name]).to include("has already been taken")
        expect(trapcard.errors[:name]).to include("has already been taken")
      end
    end

    context "is blank" do
      before { card.name = "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:name]).to include("can't be blank")
      end
    end

    context "is nil" do
      before { card.name = nil }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:name]).to include("can't be blank")
      end
    end
  end

  context "when the description" do
    context "is blank" do
      before { card.description = "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:description]).to include("can't be blank")
      end
    end

    context "is nil" do
      before { card.description = "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:description]).to include("can't be blank")
      end
    end
  end
end
