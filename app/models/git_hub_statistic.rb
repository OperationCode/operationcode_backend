class GitHubStatistic < ApplicationRecord
  PR = 'PullRequest'
  ISSUE = 'Issue'
  COMMIT = 'Commit'

  belongs_to :git_hub_user

  validates :git_hub_user_id, :source_type, :source_id, :repository, :url, :title, :completed_on, presence: true
  validates :source_id, uniqueness: { scope: :source_type }

  before_save :downcase_source_id, :downcase_repository

  scope :pull_requests, -> { where(source_type: GitHubStatistic::PR) }
  scope :issues, -> { where(source_type: GitHubStatistic::ISSUE) }
  scope :commits, -> { where(source_type: GitHubStatistic::COMMIT) }
  scope :closed, -> { where(state: 'closed') }
  scope :open, -> { where(state: 'open') }
  scope :for_git_hub_user, -> git_hub_user { where(git_hub_user_id: git_hub_user.id) }
  scope :for_repository, -> repository { where(repository: repository) }

  # For the most recently closed pull request, gets its :completed_on date.
  # If none exist, returns '1970-01-01'
  #
  # @return [String] A date in its string format
  #
  def self.last_pr_completed_on
    date = self
      .pull_requests
      .last_closed_date

    default_date date
  end

  # For the most recently closed issues, gets its :completed_on date.
  # If none exist, returns '1970-01-01'
  #
  # @return [String] A date in its string format
  #
  def self.last_issue_completed_on
    date = self
      .issues
      .last_closed_date

    default_date date
  end

  # Returns the unique count of GitHubUsers that have made a commit.
  #
  # @return [Integer]
  #
  def self.users_made_a_commit
    self
      .commits
      .pluck(:git_hub_user_id)
      .uniq
      .size
  end

  # Returns the unique count of GitHubUsers that have a closed pull request.
  #
  # @return [Integer]
  #
  def self.users_closed_a_pr
    self
      .closed
      .pull_requests
      .pluck(:git_hub_user_id)
      .uniq
      .size
  end

  # Fetches records that have a :completed_on Date bewtween the passed in start
  # and end dates.  Start date defaults to 1/1/1970.  End date defaults to today.
  #
  # @return [GitHubStatistic] ActiveRecord Collection of GitHubStatistics
  #
  def self.date_range(start_date: '1970-01-01', end_date: Date.today.to_s)
    where completed_on: (start_date..end_date)
  end

  def self.repositories
    pluck(:repository).uniq
  end

  # Returns the unique count of repositories we have statistics on.
  #
  # @return [Integer]
  #
  def self.repository_count
    repositories.size
  end

  def self.average_closed_prs_per_user
    grouped_records = pull_requests.closed.group_by(&:git_hub_user_id)

    return 0 unless grouped_records.present?

    per_user_average_in grouped_records
  end

  def self.average_commits_prs_per_user
    grouped_records = commits.group_by(&:git_hub_user_id)

    return 0 unless grouped_records.present?

    per_user_average_in grouped_records
  end

  private

  def self.per_user_average_in(grouped_records)
    per_group_totals = []

    grouped_records.each do |grouped_record|
      statistics = grouped_record.last

      per_group_totals << statistics.length
    end

    per_group_totals.sum / per_group_totals.size.to_f
  end

  def self.last_closed_date
    self
      .closed
      .order(completed_on: :desc)
      .first
      .try(:completed_on)
      .to_s
  end

  def self.default_date(date)
    date.present? ? date : '1970-01-01'
  end

  def downcase_source_id
    source_id.downcase!
  end

  def downcase_repository
    repository.downcase!
  end
end
