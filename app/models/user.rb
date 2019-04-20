class User < ApplicationRecord
  LEADER = 'community leader'

  # Validation of military_status
  CURRENT = 'current'
  VETERAN = 'veteran'
  SPOUSE = 'spouse'
  MILITARY_STATUSES = [CURRENT, VETERAN, SPOUSE, nil]
  validates :military_status, inclusion: { in: MILITARY_STATUSES }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_taggable

  geocoded_by :zip do |user, results|
    geocoded_object = results.first

    if geocoded_object.present?
      user.latitude  = geocoded_object.latitude
      user.longitude = geocoded_object.longitude
      user.state     = geocoded_object.state_code
    end
  end

  # These attributes are what we send to sendgrid as custom fields
  SENDGRID_ATTRIBUTES = %w[first_name last_name email]

  # This regex comes from the `validates_format_of` Rails docs
  #
  # @see http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html#method-i-validates_format_of
  #
  VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  before_validation :strip_zip_code
  before_validation :geocode, if: ->(v) { v.zip.present? && v.zip_changed? }
  before_save :upcase_state
  before_save :downcase_email

  validates_format_of :email, :with => VALID_EMAIL
  validates :email, uniqueness: true
  validates :zip, presence: true, :on => :create

  after_validation :log_errors, :if => proc { |m| m.errors }

  has_many :requests
  has_many :votes
  has_many :scholarship_applications

  scope :mentors, -> { where(mentor: true) }
  scope :by_zip, ->(zip) { where(zip: zip) }
  scope :by_state, ->(state) { where(state: state) }
  scope :verified, -> { where(verified: true) }


  # Returns a count of all users with the passed in zip code(s)
  #
  # @param zip_codes [String] String of comma-separated zip code(s), i.e. '80126', or '80126, 80203'
  # @return [Integer] A count of the requested users.
  #
  def self.count_by_zip(zip_codes)
    return 0 unless zip_codes.present?

    zips = FormatData.csv_to_array(zip_codes)

    self.by_zip(zips).count
  end

  # Returns a count of all users with the passed in state abbreviations.
  #
  # @param state_abbreviations [String] String of comma-separated state_abbreviations, i.e. 'CO', or 'CO, TX'
  # @return [Integer] A count of the requested users.
  #
  def self.count_by_state(state_abbreviations)
    return 0 unless state_abbreviations.present?

    states = FormatData.csv_to_array(state_abbreviations)

    self.by_state(states).count
  end

  # Returns a count of all users within the passed in location.  The location can
  # be either a city, or a set of latitude/longitude.
  #
  # @param location [String || Array] Either a 'City, State, County' or [Latitude, Longitude]
  #   For example, 'Denver, CO, US'.
  # @param radius [Integer] Include results within the radius' distance from the location, in miles.
  # @return [Integer] A count of the requested users.
  # @see https://github.com/alexreisner/geocoder#for-activerecord-models
  #
  def self.count_by_location(location, radius=20)
    near(location, radius.to_i)&.size
  end

  def self.community_leaders_nearby(latitude, longitude, radius)
    self
      .near([latitude, longitude], radius)
      .tagged_with(LEADER)
  end

  # Returns a count of users that were created since the passed in date,
  # up through today.
  #
  # @param date [Date] The date the range should begin at (i.e. Date.today, 1.week.ago)
  # @return [Intenger] A count of users
  #
  def self.count_created_since(date)
    range = date.beginning_of_day..Date.today.end_of_day

    where(created_at: range).count
  end

  def self.uniq_states
    self
      .order(:state)
      .pluck(:state)
      .uniq
      .compact
  end

  def self.all_tag_names
    tag_counts.order(:name).map(&:name)
  end

  # The presence of this method is a necessary dependency in order to
  # add a custom scope in ActiveAdmin, using Ransack
  #
  # @see User.with_tags
  # @see https://github.com/activerecord-hackery/ransack#using-scopesclass-methods
  #
  def self.ransackable_scopes(_auth_object = nil)
    [:with_tags]
  end

  # This calls the ActsAsTaggableOn#tagged_with method with the passed in tag(s)
  #
  # By setting any: true, it returns results with any of the specified tags.
  #
  # @param *args [Array<String>] Array of passed in tag name(s)
  # @return [User] ActiveRecord collection of User objects
  # @see User.ransackable_scopes
  # @see https://github.com/mbleigh/acts-as-taggable-on#finding-tagged-objects
  #
  def self.with_tags(*args)
    tagged_with(args, any: true)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def welcome_user
    add_to_send_grid
    invite_to_slack
  end

  def invite_to_slack
    SlackJobs::InviterJob.perform_async(self.email)
  end

  def add_to_send_grid
    AddUserToSendGridJob.perform_async(self.id)
  end

  def token
    JsonWebToken.encode(user_id: self.id, roles: [], email: self.email, verified: verified)
  end

  # For social media logins, When given a user's info creates their database entry if they do not already have one, and
  # sets the redirect path for the frontend to go to after the user is logged in
  # for the first time.
  #
  # Requires that all data contains :first_name, :last_name, :email, :zip, and :password keys.
  # For example: data = {first_name: "Jane", last_name: "Doe", email: "jane@example.com", zip: "12345", password: "Th!sIs@Pa22w0rd"}
  #
  # @param data The data passed in from the frontend, from which the user's info is extracted.
  # @return [String] A string of the user's redirect_to path
  # @return [Json] A serialied JSON object derived from current_user
  # @return [Token] A token that the frontend stores to know the user is logged in
  # @return [user, path] The user and the redirect path, in an array
  # @see https://github.com/zquestz/omniauth-google-oauth2#devise
  #
  def self.fetch_social_user_and_redirect_path(data)
    user = User.find_by(email: data.dig(:email))
    path = '/profile'

    if user.nil?
      user = User.new(
        first_name: data.dig(:first_name),
        last_name: data.dig(:last_name),
        email: data.dig(:email),
        zip: data.dig(:zip),
        password: data.dig(:password)
      )
      path = '/signup-info'
      UserMailer.welcome(user).deliver unless user.invalid?
    end

    [user, path]
  end

  def has_tag?(tag)
    tag_list.include? tag
  end

  def role
    return if role_id.blank?

    Role.find_by id: role_id
  end

  def generate_password_token!
    _raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    self.save
  end

  def reset_password!(new_password)
    @password = new_password
    self.encrypted_password = password_digest(@password) if @password.present?
    self.reset_password_token = nil
    self.save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  private

  def strip_zip_code
    zip.strip! if zip
  end

  def upcase_state
    state.upcase! if state
  end

  def downcase_email
    email.downcase! if email
  end

  def log_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end
end
