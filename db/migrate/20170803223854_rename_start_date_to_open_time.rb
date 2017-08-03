class RenameStartDateToOpenTime < ActiveRecord::Migration[5.0]
  def change
    rename_column :scholarships, :start_date, :open_time
    rename_column :scholarships, :end_date, :close_time
  end
end
