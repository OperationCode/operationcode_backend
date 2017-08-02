class CreateScholarships < ActiveRecord::Migration[5.0]
  def change
    create_table :scholarships do |t|
      t.string :name
      t.text :description
      t.string :location
      t.text :terms
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
