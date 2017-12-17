# The OC has end users that would like to be on our emailing list; however,
# have not committed to creating a User account with us, yet.
#
# This class allows us to create Structs for these 'guests', that respond
# identically to a User object, within the SendGridClient class.
#
class SendGridClient::Guest
  Visitor = Struct.new(:id, :email, :first_name, :last_name) do
    def attributes
      to_h.as_json
    end
  end

  # Creates a user-like Struct, to represent an OC guest.
  #
  # Defaults the :id attribute to 'guest-id', as their is no database id;
  # however, the id needs to be logged for debugging in the SendGridClient.
  #
  # @param email_address [String] A string of the guest's email address
  # @return [Struct] A user-like struct
  #
  def self.user(email_address)
    Visitor.new('guest-id', email_address, '', '')
  end
end
