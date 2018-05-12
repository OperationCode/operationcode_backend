namespace :update do
  desc 'Updates the Sabio.jpg to Sabio.png'
  task sabio: :environment do
    school = CodeSchool.find_by(name: 'Sabio')
    logo = school.logo
    logo[-3..-1] = 'png'
    school.save
  end
end
