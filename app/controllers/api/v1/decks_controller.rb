module Api
  module V1
    class DecksController < ApplicationController
      allow_unauthenticated_access

      def random
        decks = Deck.includes(:user, :archetypes, boards: [:board_type, { board_cards: :card }]).find(1)

        render json: decks, include: ['user', 'archetypes', 'boards', 'boards.board_type', 'boards.board_cards', 'boards.board_cards.card']
      end
    end
  end
end
