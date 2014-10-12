class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true, default: 2
  end
end
