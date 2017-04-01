require 'slack/client'

class SlackJobs < ActiveJob::Base
  queue_as :default

  private

  def slack_client
    @slack_client ||= Slack::Client.new(
      subdomain: ENV.fetch('SLACK_SUBDOMAIN'),
      token:     ENV.fetch('SLACK_TOKEN')
    )
  end
end
