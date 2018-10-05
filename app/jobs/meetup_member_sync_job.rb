class MeetupMemberSyncJob
  include Sidekiq::Worker

  def perform
    meetup_client = Meetup.new
    members = meetup_client.members_by_email

    User.where(email: members.keys).each do |user|
      member = members[user.email]
      user.latitude ||= member['lat']
      user.longitude ||= member['lon']
      user.city ||= member['city']
      user.state ||= member['state']

      # Only update a user if values have changed
      user.save if user.changed?
    end
  end
end
