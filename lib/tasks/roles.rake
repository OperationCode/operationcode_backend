namespace :roles do
  desc 'Creates the initial set of roles'
  task initial_set: :environment do
    ['super_admin', 'admin', 'board_member'].each do |role|
      begin
        Role.find_or_create_by!(title: role)
      rescue ActiveRecord::RecordInvalid => e
        p e.record.errors
      end
    end
  end
end
