class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create login ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def show
  end

  def new
    @user = User.new
  end

  def create
    return redirect_to signup_path, alert: "You must fill in all fields." if any_information_is_missing?

    @user = User.create(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Account Created Successfully."
    else
      redirect_to signup_path, alert: "An error occurred." # MAYBE USERNAME OR EMAIL IS TAKEN CHECK USER ERRORS
    end
  end

  def login
    @user = User.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password)
  end

  def any_information_is_missing?
    user_params.blank? || user_params[:username].blank? || user_params[:email_address].blank? || user_params[:password].blank?
  end
end
