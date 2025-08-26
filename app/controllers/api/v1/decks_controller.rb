module Api
  module V1
    class DecksController < ApplicationController
      allow_unauthenticated_access

      def random
        query = Deck.includes(:user, :archetypes, boards: [:board_type, { board_cards: :card }])
        query = query.where(tier: params[:tier].to_i) if params[:tier].present? && params[:tier] != "any"

        count = query.count
        deck = query.offset(rand(count)).first # maybe i will make it so that it returns more results and puts them in sessionstorage

        render json: deck, include: [
          'user', 
          'archetypes', 
          'boards', 
          'boards.board_type', 
          'boards.board_cards', 
          'boards.board_cards.card'
        ]
      end
    end
  end
end
