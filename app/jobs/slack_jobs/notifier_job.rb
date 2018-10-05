class SlackJobs
  class SlackNotifierJob < SlackJobs
    include Sidekiq::Worker

    def perform(_message, *)
      logger.debug 'Deprecated pathway, trying to determine what is placing this on queue.'
    end
  end
end
