class CreateDeckArchetypes < ActiveRecord::Migration[8.0]
  def change
    create_table :deck_archetypes do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :archetype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
