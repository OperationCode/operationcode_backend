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
  
  
end
