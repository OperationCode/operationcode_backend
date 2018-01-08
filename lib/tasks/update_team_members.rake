namespace :update_team_members do
  desc "Batch predetermined modification of team members"
  task update_team_member_table: :environment do

    new_members = [         
      {
        name: "Mike Nolson",
        role: "Rails Enthusiast"
      },
      {
        name: "King Tut",
        role: "Legacy Monuments"
      },
      {
        name: "Generic Senator",
        role: "On the pay-roll"
      }
    ]
    
        updated_members = [         
      {  
        name: "Aaron Suarez",
        role: "Gulf Coast Chapter Leader"      
      },
      {  
        name: "Aimee Knight",
        role: "Board Director"
      },
      {  
        name: "Alexander Laquitara",
        role: "NYC Chapter Co-Leader"
      },
      {  
        name: "Andy LaMora",
        role: "Legislative Affairs"
      }
    ]
    
    
    deleted_members = [         
      {
        name: "Reid Olmstead",
        role: "Finance & Accounting"
      },
      {
        name: "Rhonda Til",
        role: "Funding & Admin Support"
      },
      {
        name: "Rick Rein",
        role: "CTO"
      }
    ]
    
    / "find_or_create_by" calls  create!, raises an exception if created record is invalid/
    new_members.each do |new_member|
      begin
        TeamMember.find_or_create_by!(name: new_member[:name], role: new_member[:role])
      rescue => e
        Rails.logger.error "User create Error Occured.\nInput User: #{new_member}\nExperienced this error: #{e}"
      end 
    end
    
    / "update" takes in the active record id and updates the given parameters / 
    updated_members.each do |updated_member|
      ## .find_by will either find the record, or return nil
      team_member = TeamMember.find_by(name: updated_member[:name])

      ## skip to the next item in the array if team_member cannot be found in the db
      next unless team_member
  
      ## make any updates to the found team_member record
      begin
        team_member.update!(role: updated_member[:role])
      rescue => e
        Rails.logger.error "Update Error occured after user found.\nFound user: #{name:}\nRecord id #{team_member[:id]}\nExperienced this error: #{e}"
      end
    end
    
    / "destroy" not sure if this or "delete" /  
    deleted_members.each do |deleted_member|
      ## .find_by will either find the record, or return nil
      team_member = TeamMember.find_by(name: deleted_member[:name])

      ## skip to the next item in the array if team_member cannot be found in the db
      next unless team_member 
    
      ## make any updates to the found team_member record
      begin
        team_member.destroy!
      rescue => e
        Rails.logger.error "Destroy Error occured after user found.\nFound user: #{name:}\nRecord id #{team_member[:id]}\nExperienced this error: #{e}"
      end
    end
    
  end
end