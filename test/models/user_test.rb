require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    Sidekiq::Testing.fake!
  end

  def teardown
    Sidekiq::Worker.clear_all
  end

  test 'welcoming a user adds them to SendGrid' do
    user = create(:user, user_opts)
    user.welcome_user
    assert_equal 1, AddUserToSendGridJob.jobs.length
    assert_equal [user.id], AddUserToSendGridJob.jobs.first['args']
  end

  test 'must have a valid email' do
    refute User.new(email: 'bogusemail', password: 'password', zip: '97201').valid?
    assert User.new(email: 'goodemail@example.com', password: 'password', zip: '97201').valid?
  end

  test 'email must be unique' do
    test_email = 'test@example.com'
    assert create(:user, email: test_email)
    refute User.new(email: test_email, zip: '97201').valid?
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

  test 'role gets the Role with an id of user#role_id, if there is one' do
    user = create :user
    assert user.valid?
    assert user.role.nil?

    some_role = create :role
    user.update! role_id: some_role.id
    assert_equal some_role, user.role
  end

  test 'doesnt geocode until we validate' do
    u = build(:user, latitude: nil, longitude: nil)
    assert_nil u.latitude
    assert_nil u.longitude

    assert u.valid?
    assert_equal 45.505603, u.latitude
    assert_equal -122.6882145, u.longitude
  end

  test 'accepts non-us zipcodes (UK)' do
    Geocoder.configure(lookup: :google)
    u = create(:user, latitude: nil, longitude: nil, zip: 'HP2 4HG')
    assert_equal 51.75592890000001, u.latitude
    assert_equal -0.4447103, u.longitude
    Geocoder.configure(lookup: :test)
  end

  test 'empty spaces on ends of a zip code are stripped out' do
    user = create :user, zip: ' 97201 '

    assert user.zip == '97201'
  end

  test 'validates the presence of a zip' do
    user = build :user, zip: nil
    refute user.valid?
    assert_equal ["Zip can't be blank"], user.errors.full_messages

    user = build :user, zip: ''
    refute user.valid?
    assert ["Zip can't be blank"], user.errors.full_messages
  end

  test 'longitude and longitude are nil for nil zipcodes' do
    Geocoder::Lookup::Test.add_stub('bad zip code', [{}])
    u = build(:user, latitude: nil, longitude: nil, zip: nil)
    u.update_attributes(zip: nil)
    assert_nil u.latitude
    assert_nil u.longitude
  end

  test 'longitude and longitude are nil for empty zipcodes' do
    Geocoder::Lookup::Test.add_stub('bad zip code', [{}])
    u = build(:user, latitude: nil, longitude: nil, zip: '')
    u.update_attributes(zip: '')
    assert_nil u.latitude
    assert_nil u.longitude
  end

  test 'longitude and longitude are nil for unknown zipcodes' do
    Geocoder::Lookup::Test.add_stub('bad zip code', [{}])

    u = build(:user, latitude: nil, longitude: nil, zip: nil)

    u.update_attributes(zip: 'bad zip code')
    assert_nil u.latitude
    assert_nil u.longitude
  end

  test 'updates geocode after update' do
    Geocoder::Lookup::Test.add_stub('new zip code', [{ 'latitude' => 2, 'longitude' => 2, 'state_code' => 'NEW' }])
    u = build(:user, latitude: 1, longitude: 1)

    u.update_attributes(zip: 'new zip code')
    assert_equal 2, u.latitude
    assert_equal 2, u.longitude
    assert_equal 'NEW', u.state
  end

  test 'only geocodes if zip is updated' do
    u = build(:user, latitude: 1, longitude: 1, zip: '97201')
    u.stubs(:zip_changed?).returns(false)
    u.save

    u.update_attributes(email: 'updated_email@example.com')
    assert_equal 1, u.latitude
    assert_equal 1, u.longitude
    assert_equal u.zip, '97201'

    Geocoder::Lookup::Test.add_stub('new zip code', [{ 'latitude' => 2, 'longitude' => 2, 'state_code' => 'NEW' }])
    u.stubs(:zip_changed?).returns(true)
    u.update_attributes(zip: 'new zip code')
    assert_equal 2, u.latitude
    assert_equal 2, u.longitude
    assert_equal 'NEW', u.state
  end

  def user_opts
    { email: 'create_test@example.com', zip: '11772', password: 'password', password_confirmation: 'password' }
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
    coordinates = { 'first zip' => [30.285648, -97.742052],
                    'near the first zip' => [30.312601, -97.738591],
                    'not near the first zip' => [43.606690, -116.282246] }

    coordinates.each do |zip_stub, lat_log|
      Geocoder::Lookup::Test.add_stub(
        zip_stub, [{ 'latitude' => lat_log.first, 'longitude' => lat_log.second }]
      )
      create :user, zip: zip_stub
    end

    results = User.count_by_location coordinates['first zip']
    assert_equal 2, results

    results = User.count_by_location coordinates['not near the first zip']
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

  test 'VALID_EMAIL regex ensures valid formatting' do
    # valid email formats
    assert 'john@gmail.com' =~ User::VALID_EMAIL
    assert 'j@example.com' =~ User::VALID_EMAIL
    assert 'jack@anything.io' =~ User::VALID_EMAIL
    assert 'jack@anything.org' =~ User::VALID_EMAIL
    assert 'jack@anything.net' =~ User::VALID_EMAIL
    assert 'jack@anything.whatever' =~ User::VALID_EMAIL

    # invalid email formats
    refute 'johngmail.com' =~ User::VALID_EMAIL
    refute 'john#gmail.com' =~ User::VALID_EMAIL
    refute 'john@gmail' =~ User::VALID_EMAIL
    refute '@example.com' =~ User::VALID_EMAIL
  end

  test '.fetch_social_user_and_redirect_path returns the user and redirect path in an array' do
    data = { first_name: 'Sterling', last_name: 'Archer', email: 'cyril@kickme.org', zip: '12345', password: 'VoiceMail' }
    results = User.fetch_social_user_and_redirect_path(data)
    assert_equal 2, results.size
    assert_equal data[:email], results[0][:email]
    refute_nil results[1]
  end

  test '.fetch_social_user_and_redirect_path creates the user if there is none and returns the user and /signup-info in an array' do
    data = { first_name: 'Leia', last_name: 'Organa', email: 'organa@resistance.net', zip: '66666', password: 'RestInPeace' }

    results = User.fetch_social_user_and_redirect_path(data)
    userInfo = results[0]
    redirect = results[1]

    assert_equal 2, results.length
    assert_equal data[:first_name], userInfo[:first_name]
    assert_equal data[:last_name], userInfo[:last_name]
    assert_equal data[:email], userInfo[:email]
    assert_equal data[:zip], userInfo[:zip]
    assert_equal '/signup-info', redirect
  end

  test '.fetch_social_user_and_redirect_path returns the user and /profile in an array' do
    mary = create(:user, first_name: 'Henry', last_name: 'Jones', email: 'indiana@ark.net', zip: '03710', password: 'Marion' )
    data = { first_name: 'Henry', last_name: 'Jones', email: 'indiana@ark.net', zip: '03710', password: 'Marion' }

    results = User.fetch_social_user_and_redirect_path(data)
    userInfo = results[0]
    redirect = results[1]

    assert_equal 2, results.length
    assert_equal data[:first_name], userInfo[:first_name]
    assert_equal data[:last_name], userInfo[:last_name]
    assert_equal data[:email], userInfo[:email]
    assert_equal data[:zip], userInfo[:zip]
    assert_equal '/profile', redirect
  end

  test 'military status accepts valid states' do
    assert create(:user, military_status: User::CURRENT).valid?
    assert create(:user, military_status: User::VETERAN).valid?
    assert create(:user, military_status: User::SPOUSE).valid?
    assert create(:user, military_status: nil).valid?
    refute User.new(military_status: 'spaghetti monster').valid?
  end
end
