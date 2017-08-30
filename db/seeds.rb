# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Request.destroy_all
SquadMentor.destroy_all
SquadMember.destroy_all
Squad.destroy_all
User.destroy_all
Service.destroy_all

FactoryGirl.create(:user)
FactoryGirl.create(:user)
rick = FactoryGirl.create(:mentor, first_name: 'Rick', last_name: 'Rein')
nell = FactoryGirl.create(:mentor, first_name: 'Nell', last_name: 'Shamrell-Harrington')

FactoryGirl.create(:request, language: 'Ruby', requested_mentor: rick)
FactoryGirl.create(:request, language: 'Javascript')
FactoryGirl.create(:request, language: 'Ruby')
FactoryGirl.create(:request, assigned_mentor: rick)
FactoryGirl.create(:request, assigned_mentor: nell)

#Create services
["General Guidance - Voice Chat", "General Guidance - Slack Chat", "Pair Programming", "Code Review", "Mock Interview", "Resume Interview"].each do |service|
  Service.create!(:name => service)
end
20.times do
  FactoryGirl.create(:squad, :with_mentors, :with_members)
end

case Rails.env
when "development"
  terms = "* I am a servicemember, veteran and/or member of military family.
* I am willing to be interviewed pre-conference to share my story by a member of the Operation Code team.
* I am willing to document my experience and lessons learned on the conference within 48 hours of attendance.

NOTE: Unfortunately, at this time Operation Code is unable to cover travel/lodging. However, our team is actively pursuing fundraising opportunities to provide funding for this as well. "
  Scholarship.create(name: "Node Summit 2017", description: "Node Summit is the largest conference focused exclusively on Node.js and “The Ecosystem of Node”. Join us to hear from business leaders and technology experts as they discuss Node.js’ transformative role in the future of computing.", location: "MISSION BAY CONFERENCE CENTER IN SAN FRANCISCO", terms: terms, open_time: DateTime.now, close_time: DateTime.now + 30)
  Scholarship.create(name: "Open Source Summit 2017", description: "Over 2,000 developers, operators and community leadership professionals to collaborate, share information and learn about the latest in open technologies, including Linux, containers, cloud computing, DevOps and more. There’s going to be over 200+ sessions and new events including the Diversity Empowerment Summit, Open Community Conference and Hacking for Humanity - A Social Innovation Hackathon with Girls in Tech.", location: "Los Angeles, CA", terms: terms, open_time: DateTime.now, close_time: DateTime.now + 30)
  Scholarship.create(name: "Github Universe 2017", description: "Universe is the flagship user conference for the GitHub community. It is intended for developers, operations and system administrators, technical leads, entrepreneurs, and business leaders. The event includes advanced training, executive keynotes, deep-dives on open source projects, and case studies of successful software teams.
", location: "Pier 70
420 22nd Street
San Francisco, CA 94107", terms: terms, open_time: DateTime.now, close_time: DateTime.now + 30)
end
