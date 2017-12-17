class AddUserToSendGridJob < ApplicationJob
  queue_as :default

  def perform(user)
    end_user = type_of_user(user)

    SendGridClient.new.add_user(end_user)
  end

private

  # ActiveJob does not support the passing of Structs as an argument.
  # An ActiveJob::SerializationError < ArgumentError is raised.
  #
  # It does permit Arrays.  As such, a Struct can be passed within an Array.
  #
  # @see http://api.rubyonrails.org/classes/ActiveJob/SerializationError.html
  #
  def type_of_user(user)
    if user.class == Array
      user.first
    else
      user
    end
  end
end
