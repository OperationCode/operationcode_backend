require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    stub_geocoder
  end

  test 'actions are performed on user create' do
    user = build(:user, user_opts)

    SlackJobs::InviterJob.expects(:perform_later).with(user_opts[:email])
    MailchimpInviterJob.expects(:perform_later).with(email: user_opts[:email])
    AddUserToAirtablesJob.expects(:perform_later).with(user)

    assert_difference('User.count') { user.save }
  end

  test 'must have a valid email' do
    refute User.new(email: 'bogusemail', password: 'password').valid?
    assert User.new(email: 'goodemail@example.com', password: 'password').valid?
  end

  test 'email must be unique' do
    test_email = 'test@example.com'
    assert create(:user, email: test_email)
    refute User.new(email: test_email).valid?
  end

  test 'doesnt geocode until we save' do
    u = build(:user, latitude: nil, longitude: nil)
    assert u.valid?

    u.save
    assert_equal 40.7143528, u.latitude
    assert_equal -74.0059731, u.longitude
  end

  test 'updates geocode after update' do
    u = build(:user, latitude: 40.7143528, longitude: -74.0059731)

    u.update_attributes(zip: '80203')
    assert_equal 20.7143528, u.latitude
    assert_equal -174.0059731, u.longitude
  end

  test 'only geocodes if zip is updated' do
    u = create(:user, user_opts)

    Geocoder::Lookup::Test.any_instance.expects(:search).once.returns([])
    u.update_attributes(email: 'updated_email@example.com')
    refute_equal '80203', u.zip
    u.update_attributes(zip: '80203')
  end

  def user_opts
    { email: 'create_test@example.com', zip: '11772', password: 'password', password_confirmation: 'password' }
  end

  def stub_geocoder
    Geocoder.configure(:lookup => :test)
    Geocoder::Lookup::Test.add_stub(
      '80203', [
        {
          'latitude'     => 20.7143528,
          'longitude'    => -174.0059731,
          'address'      => 'Denver, CO, USA',
          'state'        => 'Colorado',
          'state_code'   => 'CO',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
    Geocoder::Lookup::Test.set_default_stub(
      [
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'address'      => 'Patchogue, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
  end
end
