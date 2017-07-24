class AddMoreAttributesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :username, :string
    add_column :users, :volunteer, :boolean, default: false
    add_column :users, :branch_of_service, :string
    add_column :users, :years_of_service, :float
    add_column :users, :pay_grade, :string
    add_column :users, :military_occupational_specialty, :string
    add_column :users, :github, :string
    add_column :users, :twitter, :string
    add_column :users, :linkedin, :string
    add_column :users, :employment_status, :string
    add_column :users, :education, :string
  end
end
