class Resource < ApplicationRecord
  acts_as_taggable

  has_many :votes

  validates :name, :url, :category, presence: true

  def self.with_tags(tags=[])
    if tags.present?
      tagged_with(tags, any: true)
    else
      all
    end
  end
end
