namespace :users do
  desc "Sets the user's :state based on user's :zip, for any any where user.state == nil"
  task populate_states: :environment do
    # https://developers.google.com/maps/documentation/geocoding/usage-limits
    GEOCODING_DAILY_MAX = 2500
    GEOCODING_PER_S_MAX = 50

    users = User.where.not(latitude: nil, longitude: nil).where(state: nil).limit(GEOCODING_DAILY_MAX)
    user_count = users.count

    return '0 eligible users to be updated' unless users.present?
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

  desc 'Tags select users as Community Leaders'
  task seed_leader: :environment do
    leaders = [
               { first_name: 'Jesse', last_name: 'James', email: 'jrjames.pdx@gmail.com' },
               { first_name: 'Vail', last_name: 'Algatt', email: 'vail.algatt@gmail.com' },
               { first_name: 'Toanh', last_name: 'Tran', email: 'toanh.t.tran@gmail.com' },
               { first_name: 'Billy', last_name: 'Le', email: 'lebilly87@gmail.com' },
               { first_name: 'Jameel', last_name: 'Matin', email: 'jameel.matin@gmail.com' },
               { first_name: 'David', last_name: 'Wayne', email: 'djwayne3@gmail.com' },
               { first_name: 'Stuart', last_name: 'Ashby', email: 'stu@codervets.org' },
               { first_name: 'Rod', last_name: 'Levy', email: 'rod@codeplatoon.org' },
               { first_name: 'Cherie', last_name: 'Burgett', email: 'cburgett@mmisac.org' },
               { first_name: 'Blair', last_name: 'Coleman', email: 'blairestellecoleman@gmail.com' },
               { first_name: 'Larry', last_name: 'Burris', email: 'larry.n.burris@gmail.com' },
               { first_name: 'Matthew', last_name: 'Bach', email: 'mbach04@gmail.com' },
               { first_name: 'Kerri-Leigh', last_name: 'Grady', email: 'klgrady@gmail.com' },
               { first_name: 'Sara', last_name: 'Blaschke', email: 'sara.blaschke@yahoo.com' },
               { first_name: 'Mercedes', last_name: 'Welch', email: 'thefamwelch@gmail.com' },
               { first_name: 'David', last_name: 'Molina', email: 'david@molinas.com' },
               { first_name: 'Conrad', last_name: 'Hollomon', email: 'conrad@operationcode.org' },
               { first_name: 'Krystyna', last_name: 'Ewing', email: 'krystyna@operationcode.org' }
              ]

    email_array = leaders.map { |u| u[:email] }
    users_id = User.where(email: email_array)

    users_id.each do |user|
      puts user.inspect
      next if user.has_tag?(User::LEADER)
      user.tag_list.add(User::LEADER)
      user.save
    end
  end
end
