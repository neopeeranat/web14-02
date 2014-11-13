class AddRouteNameToDirection < ActiveRecord::Migration
  def change
    add_column :directions, :routename, :string
  end
end
