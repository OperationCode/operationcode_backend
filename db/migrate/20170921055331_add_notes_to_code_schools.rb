class AddNotesToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :notes, :text
  end
end
