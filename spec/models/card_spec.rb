require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card){ MonsterCard.create( name: name, description: description, card_type: "dragon" )}
  let(:name){ "CardName" }
  let(:description){ "CardDescription"}

  context "when the data is correct" do
    it "is valid" do
      expect(card).to be_valid
    end
  end
  
  context "when the name" do
    context "is duplicate of another card" do
      
      it "is invalid regardless of type" do
        card

        monstercard = MonsterCard.create( name: "CardName", description: "CardDescription2", card_type: "fairy")
        spellcard = SpellCard.create( name: "CardName", description: "CardDescription2", card_type: "normal")
        trapcard = TrapCard.create( name: "CardName", description: "CardDescription2", card_type: "normal")
      
        expect(monstercard).to be_invalid
        expect(spellcard).to be_invalid
        expect(trapcard).to be_invalid
        
        expect(monstercard.errors[:name]).to include("has already been taken")
        expect(spellcard.errors[:name]).to include("has already been taken")
        expect(trapcard.errors[:name]).to include("has already been taken")
      end
    end

    context "is blank" do
      let(:name){ "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:name]).to include("can't be blank")
      end
    end

    context "is nil" do
      let(:name){ nil }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:name]).to include("can't be blank")
      end
    end
  end

  context "when the description" do
    context "is blank" do
      let(:description){ "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:description]).to include("can't be blank")
      end
    end

    context "is nil" do
      let(:description){ "" }

      it "is invalid" do
        expect(card).to be_invalid
        expect(card.errors[:description]).to include("can't be blank")
      end
    end
  end
end
