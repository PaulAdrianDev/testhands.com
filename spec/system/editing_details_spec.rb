require 'rails_helper'

RSpec.describe "Editing User Details", type: :system do
  subject(:user) { create(:user) }
  
  before do
    login_and_go_to_edit_details
  end

  context "when the user updates their details" do
    let!(:new_username) { "AnotherUsername" }
    let!(:new_email) { "another@email.com" }
    it "tells the user that it succeeded" do
      fill_in "user_username", with: new_username
      fill_in "user_email_address", with: new_email
      click_button "Update"

      expect(page).to have_content("Details changed successfully.")

      click_link "edit_user_link"
      expect(find('input#user_username').value).to eql(new_username)
      expect(find('input#user_email_address').value).to eql(new_email)
    end
  end

  def login_and_go_to_edit_details
    visit login_path
    fill_in "user_email_address", with: user.email_address
    fill_in "user_password", with: user.password
    click_button "Log In"
    click_link "Profile"
    click_link "edit_user_link"
  end
end
