class DeckArchetypeController < ApplicationController
  def create
  
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
