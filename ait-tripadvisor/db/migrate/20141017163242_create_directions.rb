class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.references :transportation, index: true
      t.references :user, index: true
      t.decimal :price , precision: 8, scale: 2

      t.timestamps
    end
    add_index "directions", ["origin_id", "destination_id", "transportation_id", "user_id"], name: "index_directions_unique", :unique => true
  end
end
