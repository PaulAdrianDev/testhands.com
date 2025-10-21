class Users::Decks::BoardsController < ApplicationController
  before_action :set_user
  before_action :set_deck
  before_action :set_board, only: %i[ edit destroy ]

  def edit
    
  end

  def create
    type = BoardType.find_by(name: params[:board_type])

    if type.blank?
      return redirect_to edit_user_deck_path(@user, @deck), alert: "An error has occured, please report this to us. INVALID_BOARD_TYPE"
    end

    board = Board.new(deck_summons: 0, hand_summons: 0, gy_banishment_summons: 0, information: "", deck: @deck, board_type: type)

    if board.save
      redirect_to edit_user_deck_board_path(@user, @deck, board), notice: "Board Added Successfuly."
    else
      redirect_to edit_user_deck_path(@user, @deck), alert: "An error has occured, please report this to us. ERROR_CREATING_BOARD"
    end
  end

  def destroy
    if @board.destroy
      redirect_to edit_user_deck_path(@user, @deck), notice: "Board Deleted Successfully."
    else
      redirect_to edit_user_deck_board_path(@user, @deck, @board), alert: "Error Deleting Board."
    end
  end

  private
  
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  def set_board
    @board = Board.find(params[:id])
  end
end