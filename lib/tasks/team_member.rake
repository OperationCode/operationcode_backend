namespace :team_member do
        desc "Initially seeds the database with OC's team members"
        task initial_seeding: :environment do
                members = [              
                        {
                                name: "Aaron Suarez",
                                role: "Gulf Coast Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Aimee Knight",
                                role: "Board Director",
                                group: nil
                        },
                        {
                                name: "Alexander Laquitara",
                                role: "NYC Chapter Co-Leader",
                                group: nil
                        },
                        {
                                name: "Andy LaMora",
                                role: "Legislative Affairs",
                                group: nil
                        },
                        {
                                name: "Ashley Templet",
                                role: "North Carolina Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Bradley Cantor",
                                role: "Legislative Affairs",
                                group: nil
                        },
                        {
                                name: "Bret Funk",
                                role: "Deploy Advisor",
                                group: nil
                        },
                        {
                                name: "Caleb Singer",
                                role: "Marketing & Development Advisor",
                                group: nil
                        },
                        {
                                name: "Charles Sipe",
                                role: "Seattle Chapter Co-Leader",
                                group: nil
                        },
                        {
                                name: "Conrad Hollomon",
                                role: "Board Director",
                                group: "board"
                        },
                        {
                                name: "Curt Arbtin",
                                role: "San Antonio Chapter Assistant",
                                group: nil
                        },
                        {
                                name: "Dane King",
                                role: "Deploy Mentor",
                                group: nil
                        },
                        {
                                name: "Dave Barner",
                                role: "Product Strategy",
                                group: nil
                        },
                        {
                                name: "David Denninger",
                                role: "Legislative Affairs",
                                group: nil
                        },
                        {
                                name: "David Marchante",
                                role: "Florida Chapter Leader",
                                group: nil
                        },
                        {
                                name: "David Molina",
                                role: "Executive Director & Member Ex Officio",
                                group: "board"
                        },
                        {
                                name: "Doug Brown",
                                role: "Scholarship Committee",
                                group: nil
                        },
                        {
                                name: "Dr. James Davis",
                                role: "Chairman",
                                group: "board"
                        },
                        {
                                name: "Dr. Stacy Chin",
                                role: "Director of Fundraising Committee",
                                group: "board"
                        },
                        {
                                name: "Dr. Tyrone Grandison",
                                role: "Vice Chairman",
                                group: "board"
                        },
                        {
                                name: "Edward Gutierrez",
                                role: "Contributing Writer",
                                group: nil
                        },
                        {
                                name: "Elmer Thomas",
                                role: "Treasurer",
                                group: "board"
                        },
                        {
                                name: "Eunice Heymann",
                                role: "Austin Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Farrah Morrisey",
                                role: "Development Advisor",
                                group: nil
                        },
                        {
                                name: "Franklin Webber",
                                role: "Scholarship Committee",
                                group: nil
                        },
                        {
                                name: "George Everts",
                                role: "Code School Outreach Specialist/Troops to Coders Lead",
                                group: nil
                        },
                        {
                                name: "Heather Baldry",
                                role: "Scholarship Committee",
                                group: nil
                        },
                        {
                                name: "Ian Lenny",
                                role: "Director of Code School Technical Assistance",
                                group: nil
                        },
                        {
                                name: "Jameel Matin",
                                role: "Silicon Beach Chapter Leader",
                                group: nil
                        },
                        {
                                name: "James Davis",
                                role: "Board Director",
                                group: nil
                        },
                        {
                                name: "James Larimer",
                                role: "Deploy Business Development",
                                group: nil
                        },
                        {
                                name: "Janine Medina",
                                role: "Legislative Director",
                                group: nil
                        },
                        {
                                name: "Jay Bloom",
                                role: "Board Advisor",
                                group: nil
                        },
                        {
                                name: "Jay Miller",
                                role: "San Diego Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Jeremy Hall",
                                role: "Product Design",
                                group: nil
                        },
                        {
                                name: "Jesse James",
                                role: "Portland Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Jessica Rose",
                                role: "Comms/Marketing",
                                group: nil
                        },
                        {
                                name: "John Bailey",
                                role: "Finance Advisor",
                                group: nil
                        },
                        {
                                name: "John Garcia",
                                role: "Board Advisor",
                                group: nil
                        },
                        {
                                name: "John Hampton",
                                role: "Director of Mentorship",
                                group: nil
                        },
                        {
                                name: "Josh Smith",
                                role: "San Diego Chapter Assistant",
                                group: nil
                        },
                        {
                                name: "Josh Springer",
                                role: "Employer Partnerships",
                                group: nil
                        },
                        {
                                name: "Joshua Breeden",
                                role: "Hampton Roads Chapter Assistant",
                                group: nil
                        },
                        {
                                name: "Juan Chavez",
                                role: "Seattle Chapter Co-Leader",
                                group: nil
                        },
                        {
                                name: "Ken Collier",
                                role: "Utah Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Kevin Falting",
                                role: "Midwest Military Outreach",
                                group: nil
                        },
                        {
                                name: "Kevin Henry",
                                role: "Social Media",
                                group: nil
                        },
                        {
                                name: "Krystyna Ewing",
                                role: "Deploy Developer & Columbus Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Harry Levine",
                                role: "Back-end Lead",
                                group: nil
                        },
                        {
                                name: "Kyle Holmberg",
                                role: "Front-end Lead",
                                group: nil
                        },
                        {
                                name: "Larry Burris",
                                role: "Hampton Roads Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Liza Rodewald",
                                role: "Director of Military Families Committee",
                                group: "board"
                        },
                        {
                                name: "Lloyd Garrison",
                                role: "San Antonio Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Lyn Dee",
                                role: "Community Engagement",
                                group: nil
                        },
                        {
                                name: "Maggie Molina",
                                role: "Community Manager & Seattle Chapter Co-Leader",
                                group: nil
                        },
                        {
                                name: "Mark Kerr",
                                role: "Chairman Emeritus & Member Ex Officio",
                                group: "board"
                        },
                        {
                                name: "Matthew Bach",
                                role: "Hampton Roads Chapter Assistant",
                                group: nil
                        },
                        {
                                name: "Meg Ludwa",
                                role: "Grant Writer",
                                group: nil
                        },
                        {
                                name: "Michael Bell",
                                role: "Director of Policy",
                                group: nil
                        },
                        {
                                name: "Mike Slagh",
                                role: "Board Advisor",
                                group: nil
                        },
                        {
                                name: "Nathanael Duke",
                                role: "Re-Deploy Coordinator",
                                group: nil
                        },
                        {
                                name: "Nell Shamrell",
                                role: "Strategic Partnerships",
                                group: nil
                        },
                        {
                                name: "Nick Krzemienski",
                                role: "Director of Deploy",
                                group: nil
                        },
                        {
                                name: "Nina Alli",
                                role: "NYC Chapter Co-Leader",
                                group: nil
                        },
                        {
                                name: "Philip Percesepe",
                                role: "Employer Partnerships",
                                group: nil
                        },
                        {
                                name: "Reid Blomquist",
                                role: "Deploy Mentor",
                                group: nil
                        },
                        {
                                name: "Reid Olmstead",
                                role: "Finance & Accounting",
                                group: nil
                        },
                        {
                                name: "Rhonda Til",
                                role: "Funding & Admin Support",
                                group: nil
                        },
                        {
                                name: "Rick Rein",
                                role: "CTO",
                                group: nil
                        },
                        {
                                name: "Rob Kriner",
                                role: "Director of Marketing",
                                group: nil
                        },
                        {
                                name: "Roy Mosby",
                                role: "Ft. Stewart - HAAF Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Shelly Xiong",
                                role: "Okinawa Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Stacy Chin",
                                role: "Grant Writer",
                                group: nil
                        },
                        {
                                name: "Steve Arcand",
                                role: "Boston Chapter Leader",
                                group: nil
                        },
                        {
                                name: "Thomas Ciszec",
                                role: "Secretary",
                                group: "board"
                        },
                        {
                                name: "Thomas Ciszek",
                                role: "Board Director",
                                group: nil
                        },
                        {
                                name: "Tyrone Grandison",
                                role: "Board Director",
                                group: nil
                        },
                        {
                                name: "Walter Valdez Santos",
                                role: "Community Support",
                                group: nil
                        }
                ]

                members.each do |member|
                        TeamMember.find_or_create_by!(name: member[:name], 
                                                      role: member[:role], 
                                                      group: member[:group]
                                                     )
                end
        end

        desc "Batch predetermined modification of team members"
        task update_table: :environment do

                new_members = [                
                        {
                                name: "Aime Black",
                                role: "Okinawa Chapter Leader"
                        },
                        {
                                name: "Amanda Dolan",
                                role: "Robbins AFB Chapter Leader"
                        },
                        {
                                name: "Amy Tan",
                                role: "CFO"
                        },
                        {
                                name: "Andrew Siemer",
                                role: "Austin Chapter Leader"
                        },
                        {
                                name: "Billy Le",
                                role: "Sacramento Chapter Leader"
                        },
                        {
                                name: "Blair Coleman",
                                role: "Ft. Bragg Chapter Leader"
                        },
                        {
                                name: "Cameron Hopkin",
                                role: "Denver Chapter Leader"
                        },
                        {
                                name: "Cherie Burgett",
                                role: "Ft. Rucker Chapter Leader"
                        },
                        {
                                name: "David Lim",
                                role: "Seattle Chapter Co-Leader"
                        },
                        {
                                name: "David Reis",
                                role: "COO, acting"
                        },
                        {
                                name: "David Wayne",
                                role: "Silicon Beach Chapter Leader"
                        },
                        {
                                name: "Jar-Ar Jamon",
                                role: "Bay Area Chapter Leader"
                        },
                        {
                                name: "Jennifer Weidman",
                                role: "CCMO, CDO"
                        },
                        {
                                name: "Julie Weinstein",
                                role: "Windward Oahu Chapter Leader"
                        },
                        {
                                name: "Kelly MacLeod",
                                role: "People Operations"
                        },
                        {
                                name: "Kerri-Leigh Grady",
                                role: "Hampton Roads Chapter Assistant"
                        },
                        {
                                name: "Kevin Lee",
                                role: "NYC Chapter Co-Leader"
                        },
                        {
                                name: "Lilian Monge",
                                role: "Silicon Beach Chapter Leader"
                        },
                        {
                                name: "Mercedes Welch",
                                role: "N. Virginia Chapter Leader"
                        },
                        {
                                name: "Rod Levy",
                                role: "Chicago Chapter Leader"
                        },
                        {
                                name: "Roy Mosby",
                                role: "Ft. Stewart - HAAF Chapter Leader"
                        },
                        {
                                name: "Ryan Pethel",
                                role: "Jacksonville Chapter Leader"
                        },
                        {
                                name: "Sarah Blaschke",
                                role: "N. Virginia Chapter Leader"
                        },
                        {
                                name: "Sean Cameron",
                                role: "San Diego Chapter Assistant"
                        },
                        {
                                name: "Stephano D'Aniello",
                                role: "General Counsel"
                        },
                        {
                                name: "Stuart Ashby",
                                role: "St. Louis Chapter Leader"
                        },
                        {
                                name: "Toanh Tran",
                                role: "Robbins AFB & Mountain Home Chapter Leader"
                        },
                        {
                                name: "Vail Algatt",
                                role: "Mountain Home Chapter Leader"
                        },
                        {
                                name: "William Montgomery",
                                role: "Denver Chapter Leader"
                        }
                ]


                ###  update title, role or group status
                updated_members = [

                        {
                                name: "Nell Shamrell",
                                role: "CTO"
                        },
                        {
                                name: "Maggie Molina",
                                role: "Code Schools"
                        },
                        {
                                name: "Harry Levine",
                                role: "Back-end Lead"
                        },
                        {
                                name: "Kyle Holmberg",
                                role: "Front-end Lead"
                        },
                        {
                                name: "Krystyna Ewing",
                                role: "Columbus Chapter Leader"
                        },
                        {
                                name: "Jameel Matin",
                                role: "Public Policy Director"
                        },
                        {
                                name: "Ashley Templet",
                                role: "CCO"
                        }
                ]

                # board members with updated titles or replaced board members
                deleted_members = [         
                        {
                                name: "Aimee Knight"
                        },
                        {
                                name: "Thomas Ciszek"
                        },
                        {
                                name: "Tyrone Grandison"
                        },
                        {
                                name: "Stacy Chin"
                        },
                ]

                ## "find_or_create_by" calls  create!, raises an exception if created record is invalid
                new_members.each do |new_member|
                        begin
                                TeamMember.find_or_create_by!(name: new_member[:name], role: new_member[:role])
                        rescue => e
                                Rails.logger.error "User create Error Occured.\nInput User: #{new_member}\nExperienced this error: #{e}"
                        end 
                end

                ## "update" takes in the active record id and updates the given parameters 
                updated_members.each do |updated_member|
                        ## .find_by will either find the record, or return nil
                        team_member = TeamMember.find_by(name: updated_member[:name])

                        ## skip to the next item in the array if team_member cannot be found in the db
                        next unless team_member

                        ## make any updates to the found team_member record
                        begin
                                team_member.update!(role: updated_member[:role])
                        rescue => e
                                Rails.logger.error "Update Error occured after user found.\nFound user: #{updated_member[:name]}\nRecord id #{team_member[:id]}\nExperienced this error: #{e}"
                        end
                end

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
