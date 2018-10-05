class AddGuestToSendGridJob
  include Sidekiq::Worker

  # Adds the passed guest to our Contact List in SendGrid.
  #
  # @param guest_email [String] A string of the guest's email
  #
  def perform(guest_email)
    SendGridClient.new.add_user guest(guest_email)
  end

private

  # Creates a user-like Struct, representing a guest.
  #
  # @param guest_email [String] A string of the guest's email
  # @return [Struct] Returns a user-like Struct
  #
  def guest(guest_email)
    SendGridClient::Guest.user(guest_email)
  end
end
