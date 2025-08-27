module Api
  module V1
    class DecksController < ApplicationController
      allow_unauthenticated_access

      def random
        deck = Deck
          .with_includes
          .with_tier(params[:tier])
          .sample # maybe i will make it so that it returns more results and puts them in sessionstorage
        
        return render json: {
          "error": "No Deck found."
        } if deck.nil?

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
