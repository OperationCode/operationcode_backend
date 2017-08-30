class CreateGitHubUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :git_hub_users do |t|
      t.integer :user_id, index: true
      t.string :git_hub_login
      t.string :avatar_url
      t.string :api_url
      t.string :html_url
      t.integer :git_hub_id

      t.timestamps
    end
  end
end
