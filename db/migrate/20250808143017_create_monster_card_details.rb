class CreateMonsterCardDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :monster_card_details do |t|
      t.string :monster_type, null: false
      t.string :monster_attribute, null: false
      t.boolean :isEffect, null: false
      t.integer :atk
      t.integer :def
      t.string :level, null: false
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
