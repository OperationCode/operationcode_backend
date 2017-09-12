class AddColumnsToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :source_id, :string, index: true, unique: true 
  	add_column :events, :source, :string, index: true
  	add_column :events, :source_updated, :datetime
  	add_column :events, :group, :string 
  end
end
