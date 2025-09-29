class MakeForeignKeysCascade < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :deck_archetypes, :decks
    add_foreign_key :deck_archetypes, :decks, on_delete: :cascade

    remove_foreign_key :boards, :decks
    add_foreign_key :boards, :decks, on_delete: :cascade

    remove_foreign_key :board_cards, :boards
    add_foreign_key :board_cards, :boards, on_delete: :cascade

    remove_foreign_key :monster_card_details, :cards
    add_foreign_key :monster_card_details, :cards, on_delete: :cascade
  end
end
