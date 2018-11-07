class CodeSchool < ApplicationRecord
  validates :name, :url, :logo, presence: true
  validates_inclusion_of :full_time, :hardware_included, :has_online, :online_only, :in => [true, false]
  has_many :locations, -> { order('state ASC, city ASC') }, dependent: :destroy

  before_create :set_valid_scheme, :if => Proc.new{ |cs| URI(cs.url).scheme.nil? }

  private

  def set_valid_scheme
    uri = URI::parse(self.url)
    if uri.scheme.nil? && uri.host.nil?
      unless uri.path.nil?
        uri.scheme = "https"
        uri.host = uri.path
        uri.path = ""
        HTTParty.get(uri.to_s, { timeout: 2 }).code rescue uri.scheme = "http"
      end
    end

    self.url = uri.to_s
  end
end
