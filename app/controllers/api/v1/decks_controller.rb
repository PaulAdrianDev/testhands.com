module Api
  module V1
    class DecksController < ApplicationController
      allow_unauthenticated_access

      def random
        decks = Deck.includes(:user, :archetypes, boards: [:board_type, { board_cards: :card }]).first

        render json: decks, include: ['user', 'archetypes', 'boards', 'boards.board_type', 'boards.board_cards', 'boards.board_cards.card']
      end

      def specific_board
        board_id = params.expect(:board_id)
        board = Board.find(board_id)
        render json: board, include: ['board_cards', 'board_cards.card']
      end
    end
  end
end
