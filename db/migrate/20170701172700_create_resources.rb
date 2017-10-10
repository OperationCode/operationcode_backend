class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :url
      t.string :category
      t.string :language
      t.boolean :paid
      t.text :notes
      t.integer :votes_count, default: 0, null: false

      t.timestamps
    end
  end
end
