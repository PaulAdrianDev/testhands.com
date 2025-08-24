class UsersController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  allow_unauthenticated_access only: %i[ new create login ]
  before_action :deny_access_if_authenticated, only: %i[ new create login ]
  before_action :set_user, only: %i[ show edit update ]

  def show
    @decks = Deck.includes(['archetypes', 'boards']).where(user: @user)
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
      render :new, status: :unprocessable_entity
    end
  end

  def login
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Details changed successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def any_information_is_missing?
    params_needed = [ :username, :email_address, :password, :password_confirmation ]

    params_needed.each { |par| return true if user_params[par].blank? }
    false
  end

  def deny_access_if_authenticated
    redirect_to root_path if authenticated?
  end
end
