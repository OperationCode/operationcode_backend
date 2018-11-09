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
        extra_message: 'Welcome to Operation Code, please continue your journey into our online community!'
      )
    end
  end
end
