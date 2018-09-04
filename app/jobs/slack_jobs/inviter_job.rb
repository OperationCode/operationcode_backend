class SlackJobs
  class InviterJob < SlackJobs
    def perform(_email)
      logger.debug 'Deprecated pathway, trying to determine what is placing this on queue.'
    end
  end
end
