namespace :team_member do
  desc "Initially seeds the database with OC's team members"
  task initial_seeding: :environment do
    members = [
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
      },
      {
        name: "Ashley Templet",
        role: "North Carolina Chapter Leader"
      },
      {
        name: "Bradley Cantor",
        role: "Legislative Affairs"
      },
      {
        name: "Bret Funk",
        role: "Deploy Advisor"
      },
      {
        name: "Caleb Singer",
        role: "Marketing & Development Advisor"
      },
      {
        name: "Charles Sipe",
        role: "Seattle Chapter Co-Leader"
      },
      {
        name: "Conrad Hollomon",
        role: "Chief of Staff & COO"
      },
      {
        name: "Curt Arbtin",
        role: "San Antonio Chapter Assistant"
      },
      {
        name: "Dane King",
        role: "Deploy Mentor"
      },
      {
        name: "Dave Barner",
        role: "Product Strategy"
      },
      {
        name: "David Denninger",
        role: "Legislative Affairs"
      },
      {
        name: "David Marchante",
        role: "Florida Chapter Leader"
      },
      {
        name: "David Molina",
        role: "Founder & Executive Director"
      },
      {
        name: "Doug Brown",
        role: "Scholarship Committee"
      },
      {
        name: "Edward Gutierrez",
        role: "Contributing Writer"
      },
      {
        name: "Elmer Thomas",
        role: "Board Director"
      },
      {
        name: "Eunice Heymann",
        role: "Austin Chapter Leader"
      },
      {
        name: "Farrah Morrisey",
        role: "Development Advisor"
      },
      {
        name: "Franklin Webber",
        role: "Scholarship Committee"
      },
      {
        name: "George Everts",
        role: "Code School Outreach Specialist/Troops to Coders Lead"
      },
      {
        name: "Heather Baldry",
        role: "Scholarship Committee"
      },
      {
        name: "Ian Lenny",
        role: "Director of Code School Technical Assistance"
      },
      {
        name: "Jameel Matin",
        role: "Silicon Beach Chapter Leader"
      },
      {
        name: "James Davis",
        role: "Board Director"
      },
      {
        name: "James Larimer",
        role: "Deploy Business Development"
      },
      {
        name: "Janine Medina",
        role: "Legislative Director"
      },
      {
        name: "Jay Bloom",
        role: "Board Advisor"
      },
      {
        name: "Jay Miller",
        role: "San Diego Chapter Leader"
      },
      {
        name: "Jeremy Hall",
        role: "Product Design"
      },
      {
        name: "Jesse James",
        role: "Portland Chapter Leader"
      },
      {
        name: "Jessica Rose",
        role: "Comms/Marketing"
      },
      {
        name: "John Bailey",
        role: "Finance Advisor"
      },
      {
        name: "John Garcia",
        role: "Board Advisor"
      },
      {
        name: "John Hampton",
        role: "Director of Mentorship"
      },
      {
        name: "Josh Smith",
        role: "San Diego Chapter Assistant"
      },
      {
        name: "Josh Springer",
        role: "Employer Partnerships"
      },
      {
        name: "Joshua Breeden",
        role: "Hampton Roads Chapter Assistant"
      },
      {
        name: "Juan Chavez",
        role: "Seattle Chapter Co-Leader"
      },
      {
        name: "Ken Collier",
        role: "Utah Chapter Leader"
      },
      {
        name: "Kevin Falting",
        role: "Midwest Military Outreach"
      },
      {
        name: "Kevin Henry",
        role: "Social Media"
      },
      {
        name: "Krystyna Ewing",
        role: "Deploy Developer & Columbus Chapter Leader"
      },
      {
        name: "Kyle Holmberg",
        role: "Python-Squad Lead"
      },
      {
        name: "Larry Burris",
        role: "Hampton Roads Chapter Leader"
      },
      {
        name: "Lloyd Garrison",
        role: "San Antonio Chapter Leader"
      },
      {
        name: "Lyn Dee",
        role: "Community Engagement"
      },
      {
        name: "Maggie Molina",
        role: "Community Manager & Seattle Chapter Co-Leader"
      },
      {
        name: "Mark Kerr",
        role: "Chairman Emeritus & JAG Brigade Chair"
      },
      {
        name: "Matthew Bach",
        role: "Hampton Roads Chapter Assistant"
      },
      {
        name: "Meg Ludwa",
        role: "Grant Writer"
      },
      {
        name: "Michael Bell",
        role: "Director of Policy"
      },
      {
        name: "Mike Slagh",
        role: "Board Advisor"
      },
      {
        name: "Nathanael Duke",
        role: "Re-Deploy Coordinator"
      },
      {
        name: "Nell Shamrell",
        role: "Strategic Partnerships"
      },
      {
        name: "Nick Krzemienski",
        role: "Director of Deploy"
      },
      {
        name: "Nina Alli",
        role: "NYC Chapter Co-Leader"
      },
      {
        name: "Philip Percesepe",
        role: "Employer Partnerships"
      },
      {
        name: "Reid Blomquist",
        role: "Deploy Mentor"
      },
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
      },
      {
        name: "Rob Kriner",
        role: "Director of Marketing"
      },
      {
        name: "Roy Mosby",
        role: "Ft. Stewart - HAAF Chapter Leader"
      },
      {
        name: "Shelly Xiong",
        role: "Okinawa Chapter Leader"
      },
      {
        name: "Stacy Chin",
        role: "Grant Writer"
      },
      {
        name: "Steve Arcand",
        role: "Boston Chapter Leader"
      },
      {
        name: "Thomas Ciszek",
        role: "Board Director"
      },
      {
        name: "Tyrone Grandison",
        role: "Board Director"
      },
      {
        name: "Walter Valdez Santos",
        role: "Community Support"
      }
    ]

    members.each do |member|
      TeamMember.find_or_create_by!(name: member[:name], role: member[:role])
    end
  end
  
  desc "Batch predetermined modification of team members"
  task update_table: :environment do

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
