class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.belongs_to :service
      t.string :language
      t.text :details
      t.belongs_to :user, foreign_key: true
      t.belongs_to :assigned_mentor, references: :users
      t.belongs_to :requested_mentor, references: :users
      t.timestamps
    end
  end
end
