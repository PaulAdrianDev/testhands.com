require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  let!(:user) { User.create(username: "Pablo", email_address: "pablo@email.com", password: "pablo123123") }

  context "when the user logs in" do
    it "redirects to root path" do
      visit login_path

      fill_in 'user_email_address', with: "pablo@email.com"
      fill_in 'user_password', with: "pablo123123"
      click_button "Log In"

      expect(page).to have_content("Logged in successfully.")
    end
  end
end
