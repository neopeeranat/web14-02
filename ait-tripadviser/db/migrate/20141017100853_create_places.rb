class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places, :id =>false do |t|
      t.integer :placeid
      t.string :name
      t.text :description
      t.timestamps
    end
    execute "ALTER TABLE places ADD PRIMARY KEY (placeid);"
  end
end
