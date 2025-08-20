class HomepageController < ApplicationController
  allow_unauthenticated_access
  def index
    @user = authenticated? ? find_session_by_cookie.user : User.new
    @tiers = {
      "any": "Random Deck",
      "1": 'Top Tier Decks',
      "2": 'Competitive Decks',
      "3": 'Competitive Potential Decks',
      "4": 'Rogue Decks',
      "5": 'Weak Decks'
    }
    @archetypes = Archetype.all
  end

  def random
    @ret = User.find(1)
    render json: @ret
  end
end
