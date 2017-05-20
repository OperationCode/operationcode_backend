# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Request.destroy_all
User.destroy_all

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
