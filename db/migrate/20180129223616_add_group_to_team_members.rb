class AddGroupToTeamMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :team_members, :group, :text, default: 'team'
    add_column :team_members, :description, :text
    add_column :team_members, :image_src, :text, default: 'images/img_unk.png'
  end
end
