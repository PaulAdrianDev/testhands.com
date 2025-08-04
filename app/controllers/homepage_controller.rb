class HomepageController < ApplicationController
  allow_unauthenticated_access
  def index
    @user = Session.find_by(id: cookies.signed[:session_id]).user
  end
end
