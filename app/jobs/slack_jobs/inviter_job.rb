class SlackJobs
  class InviterJob < SlackJobs
    include Sidekiq::Worker

    def perform(email)
      # Invites user to general channel
      Raven.user_context email: email
      Raven.tags_context slack_invite: 'yes'
      slack_client.invite(
        email: email,
        channels: ['C03GSNF77'],
        extra_message: 'Welcome to Operation Code!\n'\
        'Once you log in, please take a moment to introduce yourself in the #general channel - a bit about who you are, where you\'re coming from, and where you\'re interested in going next.\n'\
        'Thank you for joining us!\n'\
        '-from the OC volunteer team\n'\
      )
    end
  end
end
