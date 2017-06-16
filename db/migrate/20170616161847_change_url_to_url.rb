class ChangeUrlToUrl < ActiveRecord::Migration[5.0]
  def change
  	rename_column :events, :URL, :url 
  end
end
