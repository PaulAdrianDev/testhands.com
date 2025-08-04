class CreateArchetypes < ActiveRecord::Migration[8.0]
  def change
    create_table :archetypes do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :archetypes, :name, unique: true
  end
end
