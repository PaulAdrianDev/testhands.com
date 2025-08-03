class SessionsController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def create
    if user = User.authenticate_by(user_params)
      start_new_session_for user
      redirect_to root_path, notice: "Signed in successfully"
    else
      redirect_to login_path, alert: "Error logging in"
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def user_params
    params.expect(user: [ :email_address, :password ])
  end
end
