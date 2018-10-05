class Job < ApplicationRecord
  acts_as_taggable

  scope :is_open, -> { where(closed_at: nil) }
  scope :is_closed, -> { where.not(closed_at: nil) }

  def self.with_tags(*args)
    tagged_with(args, any: true)
  end
end
