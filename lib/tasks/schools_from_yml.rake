namespace :schools_from_yml do
  desc "This reads from the code_schools.yml file and creates records in the database."
  task populate_schools: :environment do 
    File.open("...my/file/path", "r") do |f|
      f.each_line do |line|
        puts line
      end
    end
  end
end
