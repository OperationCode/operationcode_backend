class AddGroupToTeamMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :team_members, :description, :text
    add_column :team_members, :group, :string, default: 'team'
    add_column :team_members, :image_src, :string, default: 'images/img_unk.png'
  end
end
