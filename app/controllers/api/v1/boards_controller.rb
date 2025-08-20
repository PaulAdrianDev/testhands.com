module Api
  module V1
    class BoardsController < ApplicationController
      allow_unauthenticated_access

      def random
        boards = Board.all
        render json: boards
      end
    end
  end
end
