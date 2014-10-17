class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.integer :price
      t.integer :placeid
      t.integer :typeid
      t.integer :destinationid
      t.integer :user_id
      t.timestamps
    end
  end
end
