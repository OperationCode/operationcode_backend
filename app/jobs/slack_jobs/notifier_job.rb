class SlackJobs
  class SlackNotifierJob < SlackJobs
    queue_as :default

    def perform(_message, *)
      logger.debug 'Deprecated pathway, trying to determine what is placing this on queue.'
    end
  end
end
