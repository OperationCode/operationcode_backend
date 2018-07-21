class AddMilitarystatusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :military_status, :string
  end
end
