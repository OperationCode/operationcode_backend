class SendEmailToLeadersJob < ActiveJob::Base
  queue_as :default

  def perform(_user_id)
    logger.debug 'Deprecated pathway, trying to determine what is placing this on queue.'
  end
end
