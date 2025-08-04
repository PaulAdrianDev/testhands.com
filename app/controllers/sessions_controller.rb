class SessionsController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to root_path, alert: "Maximum log in attempts reached. Please try again later." }
  allow_unauthenticated_access only: %i[ create ]
  before_action :deny_access_if_authenticated, only: %i[ create ]

  def create
    redirect_to root_path if authenticated?

    if user = User.authenticate_by(user_params)
      start_new_session_for user
      redirect_to root_path, notice: "Logged in successfully."
    else
      redirect_to login_path, alert: "Invalid Email or Password."
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

  def deny_access_if_authenticated
    return redirect_to root_path if authenticated?
  end
end
