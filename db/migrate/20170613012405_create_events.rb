class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :URL
      t.datetime :start_date
      t.datetime :end_date
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :scholarship_available

      t.timestamps
    end
  end
end
