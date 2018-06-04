class Job < ApplicationRecord
  acts_as_taggable

  def self.with_tags(*args)
    tagged_with(args, any: true)
  end
end
