class CreateCodeSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :code_schools do |t|
      t.string :name
      t.string :url
      t.string :logo
      t.boolean :full_time
      t.boolean :hardware_included
      t.boolean :has_online
      t.boolean :online_only

      t.timestamps
    end
  end
end
