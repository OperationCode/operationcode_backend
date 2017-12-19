class AddIndexToSourceEvents < ActiveRecord::Migration[5.0]
  def change
  	add_index :events, :source_type
  	add_index :events, :source_id
  end
end
