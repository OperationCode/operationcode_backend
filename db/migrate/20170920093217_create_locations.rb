class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.boolean :va_accepted
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.references :code_school, foreign_key: true

      t.timestamps
    end
  end
end
