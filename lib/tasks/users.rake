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
    user_records = [{id: 290, first_name: "David", last_name: "Molina"},
                    {id: 337, first_name: "Jesse", last_name: "James"},
                    {id: 3716, first_name: "Vail", last_name: "Algatt"},
                    {id: 3655, first_name: "Toanh", last_name: "Tran"},
                    {id: 1681, first_name: "Billy", last_name: "Le"},
                    {id: 1019, first_name: "Jameel", last_name: "Matin"},
                    {id: 3772, first_name: "David", last_name: "Wayne"},
                    {id: 1054, first_name: "Josh", last_name: "Smith"},
                    {id: 3659, first_name: "Stuart", last_name: "Ashby"},
                    {id: 1091, first_name: "Rod", last_name: "Levy"},
                    {id: 3578, first_name: "Cherie", last_name: "Burgett"},
                    {id: 4467, first_name: "Blair", last_name: "Coleman"},
                    {id: 1862, first_name: "Larry", last_name: "Burris"},
                    {id: 1632, first_name: "Matthew", last_name: "Bach"},
                    {id: 3677, first_name: "Kerri-Leigh", last_name: "Grady"},
                    {id: 4675, first_name: "Sara", last_name: "Blaschke"},
                    {id: 4341, first_name: "Mercedes", last_name: "Welch"},
                    {id: 1302, first_name: "Conrad", last_name: "Hollomon"},
                    {id: 3617, first_name: "Krystyna", last_name: "Ewing"}
                   ]

    id_array = users.map { |u| u[:id] }

    users_id = User.where(id: id_array)
    users_id.each do |user|
      puts user.inspect
      next if user.has_tag?(User::LEADER)
      user.tag_list.add(User::LEADER)
      user.save
    end
  end
end
