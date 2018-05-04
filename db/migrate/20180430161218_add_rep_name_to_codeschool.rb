class AddRepNameToCodeschool < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :rep_name, :string
    add_column :code_schools, :rep_email, :string
  end
end
