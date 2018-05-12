class Resource < ApplicationRecord
  acts_as_taggable

  has_many :votes

  validates :name, :url, :category, presence: true

  # Uses ActsAsTaggableOn gem to return relevant Resources.
  #
  # @see https://github.com/mbleigh/acts-as-taggable-on#usage
  #
  def self.with_tags(tags='')
    if tags.present?
      tagged_with(tags, any: true, parse: true)
    else
      all
    end
  end
end
