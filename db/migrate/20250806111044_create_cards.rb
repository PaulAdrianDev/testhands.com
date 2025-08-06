class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :card_type, null: false
      t.string :type, null: false

      t.timestamps
    end

    add_index :cards, :name, unique: true
  end
end
