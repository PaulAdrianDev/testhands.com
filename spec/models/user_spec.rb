require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  context "when all the data is correct" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  describe "when the username" do
    context "is blank" do
      before { user.username = "" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("can't be blank")
      end
    end

    context "is nil" do
      before { user.username = nil }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("can't be blank")
      end
    end

    context "is not unique (case sensitive)" do
      before { create(:user, username: "SomeUser") }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("has already been taken")
      end
    end

    context "is not unique (case insensitive)" do
      before { create(:user, username: "SoMeuSeR") }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("has already been taken")
      end
    end

    context "is too short" do
      before { user.username = "xx" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("is too short (minimum is 3 characters)")
      end
    end

    context "is too long" do
      before { user.username = "a" * 21 }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("is too long (maximum is 20 characters)")
      end
    end
  end

  describe "when the email_address" do
    context "is blank" do
      before { user.email_address = "" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("can't be blank")
      end
    end

    context "is nil" do
      before { user.email_address = nil }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("can't be blank")
      end
    end

    context "is not unique" do
      before { create(:user, email_address: "someone@email.com") }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("has already been taken")
      end
    end
  end

  describe "when the password" do
    context "is blank" do
      subject(:user) { build(:user, password: "") }

      it "is invalid" do
        expect(user.save).to be false
        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context "is nil" do
      before { user.password = nil }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context "is too short" do
      before { user.password = "short" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end

    context "is too long" do
      before { user.password = "a" * 73 }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("is too long (maximum is 72 characters)")
      end
    end
  end
end
