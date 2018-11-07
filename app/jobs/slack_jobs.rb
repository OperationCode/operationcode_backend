require 'slack/client'

class SlackJobs < ApplicationJob
  private

  def slack_client
    @slack_client ||= Slack::Client.new(
      subdomain: ENV.fetch('SLACK_SUBDOMAIN'),
      token:     ENV.fetch('SLACK_TOKEN') #admin token required to invite
    )
  end
end
