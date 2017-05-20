class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.boolean :mentor, default: false
      t.string :slack_name
      t.string :first_name
      t.string :last_name
      t.string :timezone
      t.text :bio
    end
  end
end
