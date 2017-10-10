class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.text :reason
      t.boolean :terms_accpeted
      t.references :user, foreign_key: true
      t.references :scholarship, foreign_key: true

      t.timestamps
    end
  end
end
