class AddRoleIdToAdminUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :admin_users, :role, index: true
  end
end
