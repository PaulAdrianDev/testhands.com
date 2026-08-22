class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_logged_in_user

  def set_logged_in_user
    if authenticated?
      @logged_in_user = User.find(Session.find_by(id: cookies.signed[:session_id])[:user_id])
    end
  end
end
