class CreateSquadMentors < ActiveRecord::Migration[5.0]
  def change
    create_table :squad_mentors do |t|
      t.belongs_to :squad, foreign_key: true
      t.belongs_to :mentor, references: :users
      t.timestamps
    end
    add_index(:squad_mentors, [:squad_id, :mentor_id], unique: true)
  end
end
