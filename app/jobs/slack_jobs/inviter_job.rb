class SlackJobs
  class InviterJob < SlackJobs
    def perform(email)
      # Invites user to general channel
      slack_client.invite(email: email, channels: ['C03GSNF77'])
    end
  end
end
