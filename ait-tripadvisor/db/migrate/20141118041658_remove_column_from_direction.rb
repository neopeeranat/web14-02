class RemoveColumnFromDirection < ActiveRecord::Migration
  def change
    remove_column :directions, :routename, :string
  end
end
