class CreateBoardTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :board_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :board_types, :name, unique: true
  end
end
