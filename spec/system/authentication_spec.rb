require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  context "when the user" do
    context "logs in" do
      subject(:user) { create(:user) }

      before do
        visit login_path
      end

      it "redirects to root path" do
        fill_in 'user_email_address', with: user.email_address
        fill_in 'user_password', with: user.password
        click_button "Log In"

        expect(page).to have_content("Logged in successfully.")
        expect(current_path).to eql(root_path)
      end

      context "with wrong" do
        context "email" do
          it "warns the user" do
            fill_in 'user_email_address', with: "wrong@email.com"
            fill_in 'user_password', with: user.password
            click_button "Log In"

            expect(page).to have_content("Invalid Email or Password.")
            expect(current_path).to eql(login_path)
          end
        end

        context "password" do
          it "warns the user" do
            fill_in 'user_email_address', with: user.email_address
            fill_in 'user_password', with: "wrongpassword"
            click_button "Log In"

            expect(page).to have_content("Invalid Email or Password.")
            expect(current_path).to eql(login_path)
          end
        end

        context "email and password" do
          it "warns the user" do
            fill_in 'user_email_address', with: "wrong@email.com"
            fill_in 'user_password', with: "wrongpassword"
            click_button "Log In"

            expect(page).to have_content("Invalid Email or Password.")
            expect(current_path).to eql(login_path)
          end
        end
      end
    end

    context "signs up" do
      it "redirects to root path" do
        visit signup_path

        fill_in 'user_username', with: "CoolUsername"
        fill_in 'user_email_address', with: "someonecool@email.com"
        fill_in 'user_password', with: "coolpassword123"
        fill_in 'user_password_confirmation', with: "coolpassword123"

        click_button "Sign Up"

        expect(page).to have_content("Account Created Successfully.")
        expect(current_path).to eql(root_path)
      end
    end
  end
end
