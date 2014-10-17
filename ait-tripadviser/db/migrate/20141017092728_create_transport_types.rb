class CreateTransportTypes < ActiveRecord::Migration
  def change
    create_table :transport_types, :id => false do |t|
      t.integer :typeid
      t.string :name

      t.timestamps
    end
    execute "ALTER TABLE transport_types ADD PRIMARY KEY (typeid);"
  end
end
