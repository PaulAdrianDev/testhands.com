require 'rails_helper'

RSpec.describe Archetype, type: :model do
  subject(:archetype){ build(:archetype) }

  context "when the name is" do
    context "blank" do
      it "is invalid" do
        archetype.name = ""

        expect(archetype).to be_invalid
      end
    end

    context "nil" do
      it "is invalid" do
        archetype.name = nil

        expect(archetype).to be_invalid
      end
    end
  end
end
