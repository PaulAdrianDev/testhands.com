class HomepageController < ApplicationController
  allow_unauthenticated_access
  def index
    @user = authenticated? ? find_session_by_cookie.user : User.new
  end
end
