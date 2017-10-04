class RenameApplicationsToScholarshipApplications < ActiveRecord::Migration[5.0]
  def change
    rename_table :applications, :scholarship_applications
  end
end
