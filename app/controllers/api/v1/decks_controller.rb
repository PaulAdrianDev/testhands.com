module Api
  module V1
    class DecksController < ApplicationController
      allow_unauthenticated_access

      def random
        except_id = params[:except].present? ? params[:except].to_i : -1
        ids = Deck
          .with_archetype_id(params[:archetype_id])
          .with_tier(params[:tier])
          .where.not(id: except_id)
          .pluck(:id)

        return render json: { error: "No Deck found." } if ids.empty?

        random_id = ids.sample

        deck = Deck
          .with_includes
          .find(random_id) # maybe i will add more decks to put in js variable for less queries

        render json: deck, include: [
          "user",
          "archetypes",
          "boards",
          "boards.board_type",
          "boards.board_cards",
          "boards.board_cards.card"
        ]
      end
    end
  end
end
