class AddVerifiedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verified, :boolean, default: false, null: false
  end
end
