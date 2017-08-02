class Application < ApplicationRecord
  belongs_to :user
  belongs_to :scholarship
  # before_save only verified members can submit
  delegate :name, to: :user
  delegate :email, to: :user
end
