class CreateDecks < ActiveRecord::Migration[8.0]
  def change
    create_table :decks do |t|
      t.integer :power_level, null: false
      t.text :advice
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
