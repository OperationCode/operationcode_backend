class SendEmailToLeadersJob < ApplicationJob
  include Sidekiq::Worker

  def perform(_user_id)
    logger.debug 'Deprecated pathway, trying to determine what is placing this on queue.'
  end
end
