class MakeUniqueNameInPlace < ActiveRecord::Migration
  def change
    add_index :places, :name, :unique => true
  end
end
