class CreateGitHubStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :git_hub_statistics do |t|
      t.references :git_hub_user, foreign_key: true
      t.string :source_id
      t.string :source_type
      t.string :state
      t.integer :additions
      t.integer :deletions
      t.string :repository
      t.string :url
      t.string :title
      t.string :number
      t.date :completed_on

      t.timestamps
    end
  end
end
