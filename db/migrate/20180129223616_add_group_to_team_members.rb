class AddGroupToTeamMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :team_members, :group, :text
  end
end
