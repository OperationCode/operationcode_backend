require 'test_helper'

class GitHubStatisticTest < ActiveSupport::TestCase
  setup do
    GitHubStatistic.delete_all
    GitHubUser.delete_all
  end

  test ".last_pr_completed_on returns the most recently closed pull request's :completed_on date, else '1970-01-01'" do
    GitHubStatistic.delete_all
    assert_equal '1970-01-01', GitHubStatistic.last_pr_completed_on

    statistic = create :git_hub_statistic
    assert_equal statistic.completed_on.to_s, GitHubStatistic.last_pr_completed_on
  end

  test ".last_issue_completed_on returns the most recently closed issues's :completed_on date, else '1970-01-01'" do
    GitHubStatistic.delete_all
    assert_equal '1970-01-01', GitHubStatistic.last_issue_completed_on

    statistic = create :git_hub_statistic, :issue, state: 'closed'
    assert_equal statistic.completed_on.to_s, GitHubStatistic.last_issue_completed_on
  end

  test ".users_made_a_commit returns the unique count of users that have made a commit" do
    GitHubStatistic.delete_all

    stan, david, beth = create_users 3

    create :git_hub_statistic, :commit, git_hub_user: stan
    create :git_hub_statistic, :commit, git_hub_user: stan
    create :git_hub_statistic, :commit, git_hub_user: david
    create :git_hub_statistic, git_hub_user: beth

    assert_equal GitHubStatistic.users_made_a_commit, 2
  end

  test ".users_closed_a_pr returns the unique count of users that have closed a pull request" do
    GitHubStatistic.delete_all

    stan, david, beth = create_users 3

    create :git_hub_statistic, git_hub_user: stan
    create :git_hub_statistic, git_hub_user: stan
    create :git_hub_statistic, git_hub_user: david
    create :git_hub_statistic, :commit, git_hub_user: beth

    assert_equal GitHubStatistic.users_closed_a_pr, 2
  end

  test ".repository_count returns the unique count of repositories we have statistics on" do
    GitHubStatistic.delete_all

    create :git_hub_statistic, repository: 'uno'
    create :git_hub_statistic, repository: 'uno'
    create :git_hub_statistic, repository: 'dos'

    assert_equal GitHubStatistic.repository_count, 2
  end

  test ".date_range returns records that have a :completed_on Date bewtween the passed in start and end dates" do
    GitHubStatistic.delete_all

    twenty_10 = create :git_hub_statistic, completed_on: '2010-01-15'
    twenty_14 = create :git_hub_statistic, :commit, completed_on: '2014-01-15'
    twenty_17 = create :git_hub_statistic, :issue, completed_on: '2017-01-15'

    assert_equal GitHubStatistic.date_range, [twenty_10, twenty_14, twenty_17]
    assert_equal GitHubStatistic.date_range(start_date: '2014-01-15'), [twenty_14, twenty_17]
    assert_equal GitHubStatistic.date_range(start_date: '2017-01-15'), [twenty_17]
    assert_equal GitHubStatistic.date_range(end_date: '2014-01-14'), [twenty_10]
    assert_equal GitHubStatistic.date_range(end_date: '2009-01-15'), []
    assert_equal GitHubStatistic.date_range(start_date: '2014-01-10', end_date: '2014-01-19'), [twenty_14]
  end

  test ".average_closed_prs_per_user returns a float value of the average number of pull requests closed, across all repositories, per user" do
    john = create :git_hub_user
    jack = create :git_hub_user

    3.times { create :git_hub_statistic, git_hub_user: john }
    5.times { create :git_hub_statistic, git_hub_user: jack }

    assert GitHubStatistic.average_closed_prs_per_user == 4.0
  end

  test ".average_commits_prs_per_user returns a float value of the average number of commits, across all repositories, per user" do
    john = create :git_hub_user
    jack = create :git_hub_user

    3.times { create :git_hub_statistic, :commit, git_hub_user: john }
    5.times { create :git_hub_statistic, :commit, git_hub_user: jack }

    assert GitHubStatistic.average_commits_prs_per_user == 4.0
  end

  def create_users(number)
    users = []

    number.times do
      users << create(:git_hub_user)
    end

    users
  end

  teardown do
    GitHubStatistic.delete_all
    GitHubUser.delete_all
  end
end
