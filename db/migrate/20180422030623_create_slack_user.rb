class CreateSlackUser < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_users do |t|
      t.string :slack_id, index: true
      t.string :slack_name
      t.string :slack_real_name
      t.string :slack_display_name
      t.string :slack_email, index: true, foreign_key: true
    end
  end
end
