class Application < ApplicationRecord
  # before_save only verified members can submit
  delegate :name, to: :user
  delegate :email, to: :user
end
