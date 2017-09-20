class CodeSchool < ApplicationRecord
  has_many :locations, dependent: :destroy
end
