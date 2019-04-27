class SlackJobs
  class InviterJob < SlackJobs
    include Sidekiq::Worker
    sidekiq_options retry: 5

    def perform(email)
      Raven.user_context email: email
      Raven.tags_context slack_invite: 'yes'

      SlackService::Client.new.invite(email)
    end
  end
end
