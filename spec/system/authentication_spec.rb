require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  context "when the user" do
    context "logs in" do
      let!(:user) { User.create(username: "Pablo", email_address: "pablo@email.com", password: "pablo123123") }
      
      it "redirects to root path" do
        visit login_path

        fill_in 'user_email_address', with: "pablo@email.com"
        fill_in 'user_password', with: "pablo123123"
        
        click_button "Log In"

        expect(page).to have_content("Logged in successfully.")
        expect(current_path).to eql(root_path)
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
