require 'rails_helper'

RSpec.describe Archetype, type: :model do
  context "when the name is" do
    context "blank" do
      it "is invalid" do
        archetype = Archetype.new(name: "")

        expect(archetype).to be_invalid
      end
    end

    context "nil" do
      it "is invalid" do
        archetype = Archetype.new(name: nil)

        expect(archetype).to be_invalid
      end
    end
  end
end
