class AddScholarshipInfoFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :scholarship_info, :boolean, default: false
  end
end
