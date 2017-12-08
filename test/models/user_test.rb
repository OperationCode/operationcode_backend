require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    stub_geocoder
  end

  test 'actions are performed on user create' do
    user = build(:user, user_opts)

    SlackJobs::InviterJob.expects(:perform_later).with(user_opts[:email])
    AddUserToAirtablesJob.expects(:perform_later).with(user)
    AddUserToSendGridJob.expects(:perform_later).with(user)

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

  test 'email is downcased on create' do
    u = create(:user, email: 'NEW_EMAIL@exaMple.cOm')
    assert_equal 'new_email@example.com', u.email
  end

  test 'email is downcased after update' do
    u = create(:user, email: 'UPDATE_EMAIL@exaMple.cOm')
    u.update!(email: 'UPDATE_EMAIL@exaMple.cOm')
    assert_equal 'update_email@example.com', u.email
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
    assert_equal 'CO', u.state
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

  test '.count_by_zip returns a count of all users within the passed in zip code(s)' do
    tom = create :user, zip: '80112'
    sam = create :user, zip: '80126'
    bob = create :user, zip: '80126'

    results = User.count_by_zip '80126'
    assert_equal 2, results

    results = User.count_by_zip '80126, 80112'
    assert_equal 3, results

    results = User.count_by_zip ''
    assert_equal 0, results
  end

  test '.count_by_location returns a count of all users within the passed in city, or latitude/longitude, and radius from that location' do
    tom = create :user, zip: '78705'
    sam = create :user, zip: '78756'
    bob = create :user, zip: '83704'

    tom.update latitude: 30.285648, longitude: -97.742052
    sam.update latitude: 30.312601, longitude: -97.738591
    bob.update latitude: 43.606690, longitude: -116.282246

    results = User.count_by_location [30.285648, -97.742052]
    assert_equal 2, results

    results = User.count_by_location [43.606690, -116.282246]
    assert_equal 1, results

    results = User.count_by_location ''
    assert_equal 0, results
  end

  test 'it returns a users full name' do
    assert_equal 'first last', User.new(first_name: 'first', last_name: 'last').name
  end

  test '.count_by_state returns a count of all users within the passed in state(s)' do
    tom = create :user
    sam = create :user
    bob = create :user

    tom.update_columns state: 'TX'
    sam.update_columns state: 'TX'
    bob.update_columns state: 'CA'

    results = User.count_by_state 'TX'
    assert_equal 2, results

    results = User.count_by_state 'TX, CA'
    assert_equal 3, results

    results = User.count_by_state ''
    assert_equal 0, results
  end

<<<<<<< a445b7f693b8419c2d0a0167f877140f2fa21953
<<<<<<< 2705a6fd884c123713a3c5b372de6f3745cfbe1f
  test 'VALID_EMAIL regex ensures valid formatting' do
    # valid email formats
    assert "john@gmail.com" =~ User::VALID_EMAIL
    assert "j@example.com" =~ User::VALID_EMAIL
    assert "jack@anything.io" =~ User::VALID_EMAIL
    assert "jack@anything.org" =~ User::VALID_EMAIL
    assert "jack@anything.net" =~ User::VALID_EMAIL
    assert "jack@anything.whatever" =~ User::VALID_EMAIL

    # invalid email formats
    refute "johngmail.com" =~ User::VALID_EMAIL
    refute "john#gmail.com" =~ User::VALID_EMAIL
    refute "john@gmail" =~ User::VALID_EMAIL
    refute "@example.com" =~ User::VALID_EMAIL
  end
=======
  test '.from_social returns the user and redirect path in an array' do
    results = User.from_social(data)
    assert_equal 2, results.size
    assert_equal data, results[0]
    refute_nil results[1]
  end
>>>>>>> fixed login info bug again
=======
  test '.from_social creates the user if there is none and returns the user and /signup-info in an array' do
    data = { first_name: 'Leia', last_name: 'Organa', email: 'organa@resistance.net', zip: '66666', password: 'RestInPeace' }

    results = User.from_social(data)
    userInfo = results[0]
    redirect = results[1]

    assert_equal 2, results.length
    assert_equal data[:first_name], userInfo[:first_name]
    assert_equal data[:last_name], userInfo[:last_name]
    assert_equal data[:email], userInfo[:email]
    assert_equal data[:zip], userInfo[:zip]
    assert_equal '/signup-info', redirect
  end

  test '.from_social returns the user and /profile in an array' do
    mary = create(:user, first_name: 'Henry', last_name: 'Jones', email: 'indiana@ark.net', zip: '03710', password: 'Marion' )
    data = { first_name: 'Henry', last_name: 'Jones', email: 'indiana@ark.net', zip: '03710', password: 'Marion' }

    results = User.from_social(data)
    userInfo = results[0]
    redirect = results[1]

    assert_equal 2, results.length
    assert_equal data[:first_name], userInfo[:first_name]
    assert_equal data[:last_name], userInfo[:last_name]
    assert_equal data[:email], userInfo[:email]
    assert_equal data[:zip], userInfo[:zip]
    assert_equal '/profile', redirect
>>>>>>> added unit tests for social login
  end
end
