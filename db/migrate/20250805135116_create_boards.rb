class CreateBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :boards do |t|
      t.integer :extra_deck_summons, null: false
      t.integer :hand_summons, null: false
      t.integer :gy_banishment_summons, null: false
      t.references :deck, null: false, foreign_key: true
      t.references :board_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
