class SlackTestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Operationcode::Slack::Im.new(channel: '#test', text: 'Hello from OC Backend').deliver
  end
end
