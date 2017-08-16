class AddColumnsToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :meetup_id, :string, index: true, unique: true 
  	add_column :events, :meetup_updated, :datetime
  end
end
