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
        id: 1,
        name: "Aaron Suarez",
        role: "Gulf Coast Chapter Leader"      
      },
      {  
        id: 2,
        name: "Aimee Knight",
        role: "Board Director"
      },
      {  
        id: 3,
        name: "Alexander Laquitara",
        role: "NYC Chapter Co-Leader"
      },
      {  
        id: 4,
        name: "Andy LaMora",
        role: "Legislative Affairs"
      }
    ]
    
    
    deleted_members = [         
      {
        id: 4,
        name: "Reid Olmstead",
        role: "Finance & Accounting"
      },
      {
        id: 8,
        name: "Rhonda Til",
        role: "Funding & Admin Support"
      },
      {
        id: 10,
        name: "Rick Rein",
        role: "CTO"
      }
    ]
    / "find_or_create_by" calls  create!, raises an exception if created record is invalid/
    new_members.each do |new_member|
      TeamMember.find_or_create_by!(name: new_member[:name], role: new_member[:role])
    end
    
    / "update" takes in the active record id and updates the given parameters / 
    updated_members.each do |updated_member|
      TeamMember.update(:updated_member[:id], name: updated_member[:name], role: updated_member[:role])
    end
    / "destroy" not sure if this or "delete" /  
    deleted_members.each do |deleted_member|
      TeamMember.destroy(:deleted_member[:id]
    end
    
  end
end