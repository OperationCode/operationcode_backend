class User < ApplicationRecord
  LEADER = 'community leader'

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

  after_create :welcome_user
  before_save :geocode, if: ->(v) { v.zip.present? && v.zip_changed? }
  before_save :upcase_state
  before_save :downcase_email

  validates_format_of :email, :with => VALID_EMAIL
  validates :email, uniqueness: true

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
    invite_to_slack
    add_to_airtables
    add_to_send_grid
  end

  def invite_to_slack
    SlackJobs::InviterJob.perform_later(email)
  end

  def add_to_airtables
    AddUserToAirtablesJob.perform_later(self)
  end

  def add_to_send_grid
    AddUserToSendGridJob.perform_later(self)
  end

  def token
    JsonWebToken.encode(user_id: self.id, roles: [], email: self.email, verified: verified)
  end

  def has_tag?(tag)
    tag_list.include? tag
  end

  private

  def upcase_state
   state.upcase! if state
  end

  def downcase_email
    email.downcase! if email
  end
end
