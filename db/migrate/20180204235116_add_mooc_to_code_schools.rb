class AddMoocToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :mooc, :boolean
  end
end
