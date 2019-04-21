class SlackJobs
  class InviterJob < SlackJobs
    include Sidekiq::Worker

    def perform(email)
      Raven.user_context email: email
      Raven.tags_context slack_invite: 'yes'

      PybotSlackClient.new.invite(email)
    end
  end
end
