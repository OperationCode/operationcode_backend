# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Request.destroy_all
ScholarshipApplication.destroy_all
Scholarship.destroy_all
User.destroy_all
Service.destroy_all
TeamMember.destroy_all
AdminUser.destroy_all
Role.destroy_all

FactoryGirl.create(:user)
FactoryGirl.create(:user)
rick = FactoryGirl.create(:mentor, first_name: 'Rick', last_name: 'Rein')
nell = FactoryGirl.create(:mentor, first_name: 'Nell', last_name: 'Shamrell-Harrington', verified: true)

FactoryGirl.create(:request, language: 'Ruby', requested_mentor: rick)
FactoryGirl.create(:request, language: 'Javascript')
FactoryGirl.create(:request, language: 'Ruby')
FactoryGirl.create(:request, assigned_mentor: rick)
FactoryGirl.create(:request, assigned_mentor: nell)

#Create services
["General Guidance - Voice Chat", "General Guidance - Slack Chat", "Pair Programming", "Code Review", "Mock Interview", "Resume Interview"].each do |service|
  Service.create!(:name => service)
end

# Create team members
SeedTeamMembers.seed_all

# Create Admin (development only)
super_admin = Role.create!(title: 'super_admin')
admin = Role.create!(title: 'admin')
board = Role.create!(title: 'board_member')

AdminUser.create!(email: 'super_admin@example.com', password: 'password', password_confirmation: 'password', role_id: super_admin.id) if Rails.env.development?
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: admin.id) if Rails.env.development?
AdminUser.create!(email: 'board@example.com', password: 'password', password_confirmation: 'password', role_id: board.id) if Rails.env.development?

scholarship = FactoryGirl.create(:scholarship)
FactoryGirl.create(:scholarship_application, user: nell, scholarship: scholarship)

users = User.count
requests = Request.count
services = Service.count
team_members = TeamMember.count
admin_users = AdminUser.count
scholarship_count = Scholarship.count
scholarship_app = ScholarshipApplication.count

puts 'Seeding complete.  Created:'
p "#{users} users"
p "#{requests} requests"
p "#{services} services"
p "#{team_members} team members"
p "#{admin_users} admin users"
p "#{scholarship_count} scholarships"
p "#{scholarship_app} scholarship applications"
