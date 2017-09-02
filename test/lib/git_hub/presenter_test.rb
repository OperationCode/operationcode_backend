require 'test_helper'

class GitHub::PresenterTest < ActiveSupport::TestCase
  setup do
    GitHubStatistic.delete_all
    GitHubUser.delete_all

    @backend = 'operationcode_backend'
    @frontend = 'operationcode_frontend'
    @date = 7.years.ago
    @john = create :git_hub_user, git_hub_login: 'jj'
    @jack = create :git_hub_user, git_hub_login: 'chuck'

    [@backend, @frontend].each do |repo|
      2.times { create :git_hub_statistic, repository: repo, git_hub_user: @john, additions: 5, deletions: 1 }
      3.times { create :git_hub_statistic, repository: repo, git_hub_user: @jack, additions: 10, deletions: 2 }
      2.times { create :git_hub_statistic, :commit, repository: repo, git_hub_user: @john, completed_on: @date }
      3.times { create :git_hub_statistic, :commit, repository: repo, git_hub_user: @jack }
      2.times { create :git_hub_statistic, :issue, repository: repo, state: 'closed', git_hub_user: @john }
      3.times { create :git_hub_statistic, :issue, repository: repo, state: 'closed', git_hub_user: @jack }
    end
  end

  test "#oc_totals returns totals across all repositories" do
    results = GitHub::Presenter.new({}).oc_totals

    assert results == {
      total_repositories: 2,
      total_closed_pull_requests: 10,
      total_closed_issues: 10,
      total_commits: 10,
      total_users: 2,
      total_additions: 80,
      total_deletions: 16
    }
  end

  test "#totals_by_repository returns totals grouped by repository" do
    GitHubStatistic.stubs(:repositories).returns([@backend, @frontend])

    results = GitHub::Presenter.new({}).totals_by_repository

    assert results == {
      operationcode_backend: {
        total_closed_pull_requests: 5,
        total_closed_issues: 5,
        total_commits: 5,
        total_users: 2,
        total_additions: 40,
        total_deletions: 8
      },
      operationcode_frontend: {
        total_closed_pull_requests: 5,
        total_closed_issues: 5,
        total_commits: 5,
        total_users: 2,
        total_additions: 40,
        total_deletions: 8
      }
    }
  end

  test "#totals_for_user returns totals for a passed in user, across all repositories" do
    jacks_results = GitHub::Presenter.new({ git_hub_login: @jack.git_hub_login }).totals_for_user
    johns_results = GitHub::Presenter.new({ git_hub_login: @john.git_hub_login }).totals_for_user

    assert jacks_results == {
      total_closed_pull_requests: 6,
      total_closed_issues: 6,
      total_commits: 6,
      total_additions: 60,
      total_deletions: 12
    }

    assert johns_results == {
      total_closed_pull_requests: 4,
      total_closed_issues: 4,
      total_commits: 4,
      total_additions: 20,
      total_deletions: 4
    }
  end

  test "#oc_averages returns averages across all repositories" do
    results = GitHub::Presenter.new({}).oc_averages

    assert results == {
      average_commits_per_user: 5.0,
      average_closed_prs_per_user: 5.0
    }
  end

  test "#totals_for_user_in_repository returns totals for a passed in user and repository" do
    john_backend = GitHub::Presenter.new({
      git_hub_login: @john.git_hub_login,
      repository: @backend
    }).totals_for_user_in_repository

    jack_frontend = GitHub::Presenter.new({
      git_hub_login: @jack.git_hub_login,
      repository: @frontend
    }).totals_for_user_in_repository

    assert john_backend == {
      total_closed_pull_requests: 2,
      total_closed_issues: 2,
      total_commits: 2,
      total_additions: 10,
      total_deletions: 2
    }

    assert jack_frontend == {
      total_closed_pull_requests: 3,
      total_closed_issues: 3,
      total_commits: 3,
      total_additions: 30,
      total_deletions: 6
    }
  end

  test "passing in optional start_date or end_date params scopes the query to those date ranges" do
    week_after = (@date + 1.week).to_s
    with_start = GitHub::Presenter.new({ start_date: week_after }).oc_totals
    with_end   = GitHub::Presenter.new({ end_date: week_after }).oc_totals
    with_both  = GitHub::Presenter.new({ start_date: week_after, end_date: week_after }).oc_totals

    assert with_start == {
      :total_repositories=>2,
      total_closed_pull_requests: 10,
      total_closed_issues: 10,
      total_commits: 6,
      total_users: 1,
      total_additions: 80,
      total_deletions: 16
    }

    assert with_end == {
      total_repositories: 2,
      total_closed_pull_requests: 0,
      total_closed_issues: 0,
      total_commits: 4,
      total_users: 1,
      total_additions: 0,
      total_deletions: 0
    }

    assert with_both == {
      total_repositories: 0,
      total_closed_pull_requests: 0,
      total_closed_issues: 0,
      total_commits: 0,
      total_users: 0,
      total_additions: 0,
      total_deletions: 0
    }
  end
end
