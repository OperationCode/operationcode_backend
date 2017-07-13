class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  geocoded_by :zip

  after_create :welcome_user
  before_save :geocode, if: ->(v) { v.zip.present? && v.zip_changed? }

  validates_format_of :email, :with => /\A.*@.*\z/
  validates :email, uniqueness: true

  has_many :requests
  has_many :led_squads, class_name: 'Squad', foreign_key: :leader_id
  has_many :votes

  scope :mentors, -> { where(mentor: true) }
  scope :by_zip, ->(zip) { where(zip: zip) }

  # Returns a count of all users with the passed in zip code(s)
  #
  # @param zip_codes [String] String of comma-separated zip code(s), i.e. '80126', or '80126, 80203'
  #
  def self.count_by_zip(zip_codes)
    return 0 unless zip_codes.present?

    zips = zip_codes.split(',').map(&:strip)

    by_zip(zips).count
  end

  # Returns a count of all users within the passed in location.  The location can
  # be either a city, or a set of coordinates.
  #
  # @param location [String || Array] Either a 'City, State, County' or [Latitude, Longitude]
  #   For example, 'Denver, CO, US'.
  # @param radius [Integer] Include results within the radius' distance from the location, in miles.
  # @see https://github.com/alexreisner/geocoder#for-activerecord-models
  #
  def self.count_by_location(location, radius=20)
    near(location, radius.to_i)&.size
  end

  def welcome_user
    invite_to_slack
    add_to_mailchimp
    add_to_airtables
  end

  def invite_to_slack
    SlackJobs::InviterJob.perform_later(email)
  end

  def add_to_mailchimp
    MailchimpInviterJob.perform_later(email: email)
  end

  def add_to_airtables
    AddUserToAirtablesJob.perform_later(self)
  end

  def token
    JsonWebToken.encode(user_id: self.id, roles: [])
  end
end
