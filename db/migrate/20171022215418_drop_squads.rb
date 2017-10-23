class DropSquads < ActiveRecord::Migration[5.0]
  def change
    drop_table :squad_members
    drop_table :squad_mentors
    drop_table :squads
  end
end
