class Users::DecksController < ApplicationController
  before_action :get_user

  def new
    @deck = @user.decks.build
  end

  def show

  end

  private

  def get_deck
    @deck = Deck.find(params[:deck_id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end
end