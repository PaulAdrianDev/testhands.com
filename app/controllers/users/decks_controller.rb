class Users::DecksController < ApplicationController
  before_action :get_user
  before_action :get_deck, only: %i[ show edit destroy ]

  def new
    @deck = Deck.create!(tier: 5, advice: nil, user: @user)
    redirect_to edit_user_deck_path(@user, @deck)
  end

  def show
  end

  def edit
    @archetypes = Archetype.all
  end

  def destroy
    if @deck.destroy
      redirect_to user_path(@user), notice: "Deck Deleted Successfully."
    else
      redirect_to user_path(@user), alert: "Error Deleting Deck."
    end
  end

  private

  def get_deck
    @deck = @user.decks.find(params[:id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end
end