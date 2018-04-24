class AddEmailToTeamMember < ActiveRecord::Migration[5.0]
  def change
    add_column :team_members, :email, :string, limit: 255
  end
end
