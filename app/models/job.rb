class Job < ApplicationRecord
  acts_as_taggable

  scope :is_available, -> { where(is_open: true) }
  def self.with_tags(*args)
    tagged_with(args, any: true)
  end
end
