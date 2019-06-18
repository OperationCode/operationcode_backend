class CodeSchool < ApplicationRecord
  validates :name, :url, :logo, presence: true
  validates_inclusion_of :full_time, :hardware_included, :has_online, :online_only, :in => [true, false]
  has_many :locations, -> { order('state ASC, city ASC') }, dependent: :destroy

  before_create :check_scheme

  private

  def check_scheme
    uri = URI.parse(url)
    update_url(uri) if uri.scheme.nil?
  end

  def update_url(uri)
    candidate = 'https://' << uri.to_s
    begin
      HTTParty.get(candidate, timeout: 2)
    rescue StandardError
      candidate.sub!('s', '')
    end
    self.url = candidate
  end
end
