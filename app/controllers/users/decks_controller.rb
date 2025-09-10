class Users::DecksController < ApplicationController
  before_action :get_user
  before_action :get_deck, only: [ :show ]

  def new
    @deck = @user.decks.build
  end

  def show
    set_deck_title
  end

  private

  def get_deck
    @deck = @user.decks.find(params[:id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end

  def set_deck_title
    @title = ""
    @deck.archetypes.each do |archetype|
      @title = "#{@title} #{archetype.name}"
    end
  end
end