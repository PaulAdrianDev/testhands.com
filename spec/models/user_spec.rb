require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ User.new(username: username, email_address: email_address, password: password) }
  let(:username){ "SomeUser" }
  let(:email_address){ "someuser@email.com" }
  let(:password){ "password123" }

  context "when all the data is correct" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  context "when the username" do
    context "is blank" do
      let(:username){ "" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("can't be blank")
      end
    end

    context "is nil" do
      let(:username){ nil }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:username]).to include("can't be blank")
      end
    end

    context "is same as another user" do
      context "(case sensitive)" do
        let!(:user2){ User.create(username:"SomeUser", email_address: "someoneelse@email.com", password:"password123")}

        it "is invalid" do
          expect(user).to be_invalid
          expect(user.errors[:username]).to include("has already been taken")
        end
      end

      context "(case insensitive)" do
        let!(:user2){ User.create(username:"SoMeuSeR", email_address: "someoneelse@email.com", password:"password123")}

        it "is invalid" do
          expect(user).to be_invalid
          expect(user.errors[:username]).to include("has already been taken")
        end
      end
    end

    context "has length" do
      context "less than 3 characters" do
        let(:username){ "xx" }

        it "is invalid" do
          expect(user).to be_invalid
          expect(user.errors[:username]).to include("is too short (minimum is 3 characters)")
        end
      end

      context "more than 20 characters" do
        let(:username){ "012345678901234567891"}

        it "is invalid" do
          expect(user).to be_invalid
          expect(user.errors[:username]).to include("is too long (maximum is 20 characters)")
        end
      end
    end
  end

  context "when the email address" do
    context "is blank" do
      let(:email_address){ "" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("can't be blank")
      end
    end

    context "is nil" do
      let(:email_address){ nil }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("can't be blank")
      end
    end
    
    context "is same as another user" do
      let!(:user2){ User.create(username:"OtherUser", email_address: "someuser@email.com", password:"password123")}

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:email_address]).to include("has already been taken")
      end
    end
  end

  context "when the password" do
    context "is blank" do
      let(:password){ "" }
      
      it "is invalid" do
        expect(user).to be_invalid

        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context "is nil" do
      let(:password){ nil }
      
      it "is invalid" do
        expect(user).to be_invalid

        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context "is less than 8 characters" do
      let(:password){ "123" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end

    context "is more than 72 characters" do
      let(:password){ "01234567890123456789012345678901234567890123456789012345678901234567890123" }

      it "is invalid" do
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("is too long (maximum is 72 characters)")
      end
    end
  end
end
