class AddIndexToSourceEvents < ActiveRecord::Migration[5.0]
  def change
  	add_index :events, :source
  	add_index :events, :source_id
  end
end
