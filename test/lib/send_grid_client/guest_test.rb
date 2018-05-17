require 'test_helper'

class SendGridClient::GuestTest < ActiveSupport::TestCase
  test '#user creates a user-like Struct, to represent an OC guest' do
    guest = SendGridClient::Guest.user(valid_email)

    assert guest.to_s.include?('struct')
  end

  test "#user creates an :id method that defaults to 'guest-id'" do
    guest = SendGridClient::Guest.user(valid_email)

    assert guest.id == 'guest-id'
  end

  test '#user creates an :email method that is set to the passed email address' do
    guest = SendGridClient::Guest.user(valid_email)

    assert guest.email == valid_email
  end

  test "#attributes returns JSON for the Struct's id, first_name, last_name, and email" do
    guest = SendGridClient::Guest.user(valid_email)

    assert guest.attributes == {
      'id' => 'guest-id',
      'email' => valid_email,
      'first_name' => '',
      'last_name' => ''
    }
  end
end

def valid_email
  'john@gmail.com'
end
