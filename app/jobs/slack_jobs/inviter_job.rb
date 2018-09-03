class SlackJobs
  class InviterJob < SlackJobs
    def perform(email)
      # Invites user to general channel
      logger.debug "Deprecated pathway, trying to determine what is placing this on queue."

    end
  end
end
