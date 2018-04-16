namespace :users do
  desc "Sets the user's :state based on user's :zip, for any any where user.state == nil"
  task populate_states: :environment do
    # https://developers.google.com/maps/documentation/geocoding/usage-limits
    GEOCODING_DAILY_MAX = 2500
    GEOCODING_PER_S_MAX = 50

    users = User.where.not(latitude: nil, longitude: nil).where(state: nil).limit(GEOCODING_DAILY_MAX)
    user_count = users.count

    return "0 eligible users to be updated" unless users.present?
    p "#{user_count} users are eligible to be updated."

    users.in_batches(of: GEOCODING_PER_S_MAX).each_with_index do |batch, batch_index|
      batch.each_with_index do |user, index|
        p "Updating #{(batch_index * GEOCODING_PER_S_MAX) + index + 1} of #{user_count}"

        begin
          results = Geocoder.search([user.latitude, user.longitude]).try(:first)

          raise "Could not geocode User id #{user.id}" unless results.present?

          user.update! state: results.state_code
        rescue => e
          p "When adding the :state for User id #{user.id}, experienced this error: #{e}"
          Rails.logger.info "When adding the :state for User id #{user.id}, experienced this error: #{e}"
        end
      end

      sleep 2
    end

    remaining = User.where.not(latitude: nil, longitude: nil).where(state: nil).count
    p "#{remaining} users left to be updated.  Task can be reran in 24 hours."
  end

  desc "Tags select users as Community Leaders"
  task seed_leader: :environment do
    users = [ {id: 4, first_name: 'Nell', last_name: 'Shamrell-Harrington' }, {id: 3, first_name: 'Rick', last_name: 'Rein'}]
    users_id = User.where(id: [3,4])
    users_id.each do |user|
      user.tag_list.add(User::LEADER)
      user.save
    end
  end
end


  desc "Tags select users as Community Leaders"
  task seed_leader: :environment do
    users = [ {id: 4, first_name: 'Nell', last_name: 'Shamrell-Harrington' }, {id: 3, first_name: 'Rick', last_name: 'Rein'}]

    id_array = []

     users.each do |user|
      id_array.push(user[:id])
    end

    users_id = User.where(id: id_array)
    users_id.each do |user|
      puts user.inspect
      user.tag_list.add(User::LEADER)
      user.save
    end
  end
