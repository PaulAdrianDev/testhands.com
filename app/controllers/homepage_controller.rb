class HomepageController < ApplicationController
  allow_unauthenticated_access
  def index
    @user = find_session_by_cookie.user
  end
end
