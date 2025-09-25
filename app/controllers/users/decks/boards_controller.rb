class Users::Decks::BoardsController < ApplicationController
  before_action :set_user
  before_action :set_deck

  def new

  end

  private
  
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
end