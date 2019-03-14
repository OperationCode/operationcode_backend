class AddUserToSendGridJob < ApplicationJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    
    SendGridClient.new.add_user(user)
  end
end
