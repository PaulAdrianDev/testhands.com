class DeckArchetypeController < ApplicationController
  def create
    deck_id = params.expect(:deck_id)
    archetype_id = params.expect(:archetype_id)

    deck_archetype = DeckArchetype.new(deck_id: deck_id, archetype_id: archetype_id)

    if deck_archetype.save
      redirect_back fallback_location: root_path, notice: "Archetype Added Successfully."
    else
      redirect_back fallback_location: root_path, alert: "Error Adding Archetype."
    end
  end

  def destroy
    deck_archetype = DeckArchetype.find(params.expect(:id))

    if deck_archetype.destroy
      redirect_back fallback_location: root_path, notice: "Archetype Removed Successfully."
    else
      redirect_back fallback_location: root_path, alert: "Error Removing Archetype."
    end
  end
end
