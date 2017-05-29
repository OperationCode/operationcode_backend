class CreateSquads < ActiveRecord::Migration[5.0]
  def change
    create_table :squads do |t|
      t.string :name
      t.text :description
      t.belongs_to :leader, references: :users
      t.integer :minimum
      t.integer :maximum
      t.string :skill_level
      t.text :activities
      t.text :end_condition

      t.timestamps
    end
  end
end
