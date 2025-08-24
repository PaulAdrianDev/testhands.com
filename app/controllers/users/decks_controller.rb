class Users::DecksController < ApplicationController
  before_action :get_user
  def index
  end

  def new
    @deck = @user.decks.build
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end
end