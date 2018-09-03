class SlackJobs
  class SlackNotifierJob < SlackJobs
    queue_as :default

    def perform(message, channel: '#general')
      logger.debug "Deprecated pathway, trying to determine what is placing this on queue."
    end
  end
end
