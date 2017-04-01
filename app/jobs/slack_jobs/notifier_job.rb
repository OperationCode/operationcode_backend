class SlackJobs
  class SlackNotifierJob < SlackJobs
    queue_as :default

    def perform(message, channel: '#general')
      res = slack_client.post_message_to channel: channel, with_text: message
      Rails.logger.debug("Notified channel: #{res.inspect}")
    end
end
