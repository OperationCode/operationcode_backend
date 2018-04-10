class SendEmailToLeadersJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    User.near([user.latitude, user.longitude],50)
        .tagged_with('community-leader').each do |leader|
      UserMailer.new_user_in_leader_area(leader, user)
    end
  end

end
