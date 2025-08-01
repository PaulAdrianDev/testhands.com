class SessionsController < ApplicationController

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
