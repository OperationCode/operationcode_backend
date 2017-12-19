class GitHubUser < ApplicationRecord
  has_many :git_hub_statistics

  validates :git_hub_login, presence: true
end
