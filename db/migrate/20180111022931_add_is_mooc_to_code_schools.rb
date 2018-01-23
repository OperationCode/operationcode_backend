class AddIsMoocToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :is_mooc, :boolean
  end
end
