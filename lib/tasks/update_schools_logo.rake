namespace :update do
  desc 'Update code schools logo from github assets to AWS S3'
  task school_logos: :environment do
    schools = CodeSchool.all
    schools.each do |school|
      logo = school.logo
      if logo.include? 'https://raw.githubusercontent.com/OperationCode/operationcode_frontend/master/src/images'
        new_logo = logo.sub('https://raw.githubusercontent.com/OperationCode/operationcode_frontend/master/src/images', 'https://s3.amazonaws.com/operationcode-assets')
        
        school.logo = new_logo
        school.save
      end
    end
  end
end
