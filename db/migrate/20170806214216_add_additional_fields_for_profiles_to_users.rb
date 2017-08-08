class AddAdditionalFieldsForProfilesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :company_role, :string
    add_column :users, :company_name, :string
    add_column :users, :education_level, :string
    add_column :users, :interests, :string
  end
end
