class AddUserToSendGridJob < ApplicationJob
  queue_as :default

  # Adds the passed user, or guest, to our Contact List in SendGrid.
  #
  # @param user [User] An ActiveRecord instance of the User class
  # @param guest_email [String] A string of the guest's email
  #   A guest_email is only provided when we do not have a User object,
  #   and vice versa.
  #
  def perform(user, guest_email: nil)
    end_user = type_of_user(user, guest_email)

    SendGridClient.new.add_user(end_user)
  end

private

  # Determines if the end user being added is a persisted User,
  # or a guest.
  #
  # This is necessary because ActiveJob does not support the passing
  # of Structs as an argument. An ActiveJob::SerializationError < ArgumentError
  # is raised.
  #
  # @param user [User] An ActiveRecord instance of the User class
  # @param guest_email [String] A string of the guest's email
  # @return [User] Returns the passed User, if user is provided
  # @return [Struct] Returns a user-like Struct if guest_email is provided
  # @see http://api.rubyonrails.org/classes/ActiveJob/SerializationError.html
  #
  def type_of_user(user, guest_email)
    if guest_email && user.nil?
      guest(guest_email)
    else
      user
    end
  end

  # Creates a user-like Struct, representing a guest.
  #
  # @param guest_email [String] A string of the guest's email
  # @return [Struct] Returns a user-like Struct
  #
  def guest(guest_email)
    SendGridClient::Guest.user(guest_email)
  end
end
