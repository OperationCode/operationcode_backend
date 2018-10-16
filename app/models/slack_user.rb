class SlackUser < ApplicationRecord
  validates :slack_id, :slack_name, :slack_real_name, :slack_email, presence: true
end
