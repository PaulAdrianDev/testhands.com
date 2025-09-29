class DeckArchetypeController < ApplicationController
  def create
    deck = Deck.find(params.expect(:deck_id))
    archetype = Archetype.find(params.expect(:archetype_id))
    user = deck.user

    deck_archetype = DeckArchetype.new(deck: deck, archetype: archetype)

    if deck_archetype.save
      redirect_to edit_user_deck_path(user, deck), notice: "Archetype Added Successfully."
    else
      redirect_to edit_user_deck_path(user, deck), alert: "Error Adding Archetype."
    end
  end

  def destroy
    deck_archetype = DeckArchetype.find(params.expect(:id))
    deck = deck_archetype.deck
    user = deck.user

    if deck_archetype.destroy
      redirect_to edit_user_deck_path(user, deck), notice: "Archetype Removed Successfully."
    else
      redirect_to edit_user_deck_path(user, deck), alert: "Error Removing Archetype."
    end
  end
end
