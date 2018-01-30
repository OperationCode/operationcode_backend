class AddGroupToTeamMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :team_members, :description, :text
    add_column :team_members, :group, :string
    add_column :team_members, :image_src, :string
  end
end
