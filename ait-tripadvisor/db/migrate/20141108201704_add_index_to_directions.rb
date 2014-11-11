class AddIndexToDirections < ActiveRecord::Migration
  def change
    add_index "directions", ["origin_id", "destination_id", "transportation_id", "user_id"], name: "index_directions_unique", :unique => true
  end
end
