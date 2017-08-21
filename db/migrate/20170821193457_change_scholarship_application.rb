class ChangeScholarshipApplication < ActiveRecord::Migration[5.0]
  def change
    rename_column :scholarship_applications, :terms_accpeted, :terms_accepted
  end
end
