class RenamingFields < ActiveRecord::Migration[8.0]
  def change
    rename_column :decks, :power_level, :tier
    rename_column :boards, :extra_deck_summons, :deck_summons
  end
end
