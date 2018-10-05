class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :source_url
      t.string :source
      t.string :city
      t.string :state
      t.string :country
      t.text :description
      t.boolean :active, default: true 
      t.boolean :remote, default: false

      t.timestamps
    end
  end
end
