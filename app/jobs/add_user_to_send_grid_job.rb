class AddUserToSendGridJob < ApplicationJob
  queue_as :default

  def perform(user)
    SendGridClient.new.add_user(user)
  end
end
