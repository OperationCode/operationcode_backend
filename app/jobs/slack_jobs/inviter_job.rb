class SlackJobs
  class InviterJob < SlackJobs
    include Sidekiq::Worker

    def perform(email)
      # Invites user to general channel
      Raven.user_context email: email
      Raven.tags_context slack_invite: 'yes'
      slack_client.invite(
        email: email,
        channels: ['C1T66M57G'],
        extra_message: 'Welcome to Operation Code! After logging in, please introduce yourself in the #general channel - a bit about who you are, where you\'re coming from, and where you\'re interested in going next.
      )
    end
  end
end
