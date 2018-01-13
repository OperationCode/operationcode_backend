namespace :update_team_members do
  desc "Batch predetermined modification of team members"
  task update_team_member_table: :environment do

    new_members = [         
      {
        name: "David Reis",
        role: "Chief Operations / Chief Data Officer"
      },
      {
        name: "Jeremy Hall",
        role: "Growth/Relationships"
      },
      {
        name: "Jennifer Weiderman",
        role: "Chief Communications Officer"
      },
      {
        name: "Amy Tan",
        role: "Chief Finance Officer"
      },
      {
        name: "Kate Horner",
        role: "Director of Programs"
      }
    ]
    
    ### Currently no actual updates need to be done 
    #updated_members = [         
    #  {  
    #    name: "David Reis",
    #    role: "Gulf Coast Chapter Leader"      
    #  },
    #  {  
    #    name: "Aimee Knight",
    #    role: "Board Director"
    #  }
    #]
    
    # members who are now board memembers and transitioning to static content
    deleted_members = [         
      {
        name: "Aimee Knight"
      },
      {
        name: "Elmer Thomas"
      },
      {
        name: "James Davis"
      },
      {
        name: "Jay Bloom"
      },
      {
        name: "John Garcia"
      },
      {
        name: "Mark Kerr"
      },
      {
        name: "Mike Slagh"
      },
      {
        name: "Thomas Ciszek"
      },
      {
        name: "Tyrone Grandison"
      } 
    ]
    
    ## "find_or_create_by" calls  create!, raises an exception if created record is invalid
    new_members.each do |new_member|
      begin
        TeamMember.find_or_create_by!(name: new_member[:name], role: new_member[:role])
      rescue => e
        Rails.logger.error "User create Error Occured.\nInput User: #{new_member}\nExperienced this error: #{e}"
      end 
    end
    
    ### "update" takes in the active record id and updates the given parameters 
    #updated_members.each do |updated_member|
    #  ## .find_by will either find the record, or return nil
    #  team_member = TeamMember.find_by(name: updated_member[:name])
    #
    #  ## skip to the next item in the array if team_member cannot be found in the db
    #  next unless team_member
    #
    #  ## make any updates to the found team_member record
    #  begin
    #    team_member.update!(role: updated_member[:role])
    #  rescue => e
    #    Rails.logger.error "Update Error occured after user found.\nFound user: #{updated_member[:name]}\nRecord id #{team_member[:id]}\nExperienced this error: #{e}"
    #  end
    #end
    
    ## "destroy" not sure if this or "delete"   
    deleted_members.each do |deleted_member|
      team_member = TeamMember.find_by(name: deleted_member[:name])

      next unless team_member 
    
      begin
        team_member.destroy!
      rescue => e
        Rails.logger.error "Destroy Error occured after user found.\nFound user: #{deleted_member[:name]}\nRecord id #{team_member[:id]}\nExperienced this error: #{e}"
      end
    end
    
  end
end
