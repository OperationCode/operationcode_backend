class AddMoocToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :mooc, :boolean, null: false, default: false
  end
end
