class AddMembersToSquads < ActiveRecord::Migration[5.0]
  def change
    create_table :squad_members do |t|
      t.belongs_to :squad, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
    add_index(:squad_members, [:squad_id, :user_id], unique: true)
  end
end

