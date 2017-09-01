module GitHub
  class Presenter
    attr_reader :params

    def initialize(params={})
      @params = params
    end

    def oc_totals
      {
        total_repositories: base_query.repository_count,
        total_closed_pull_requests: base_query.pull_requests.count,
        total_open_issues: base_query.issues.open.count,
        total_commits: base_query.commits.count,
        total_users: base_query.users_made_a_commit,
        total_additions: base_query.sum(:additions),
        total_deletions: base_query.sum(:deletions),
      }
    end

    def totals_by_repository
      GitHubStatistic.respositories.each_with_object({}) do |repo, totals|
        totals[repo.to_sym] = {
          total_closed_pull_requests: base_query.for_repository(repo).pull_requests.count,
          total_open_issues: base_query.for_repository(repo).issues.open.count,
          total_commits: base_query.for_repository(repo).commits.count,
          total_users: base_query.for_repository(repo).users_made_a_commit,
          total_additions: base_query.for_repository(repo).sum(:additions),
          total_deletions: base_query.for_repository(repo).sum(:deletions),
        }
      end
    end

    def totals_for_user
      user = GitHubUser.find_by(git_hub_login: params[:git_hub_login])

      raise 'Could not find a user with that GitHub login.' unless user

      {
        total_closed_pull_requests: base_query.for_git_hub_user(user).pull_requests.count,
        total_open_issues: base_query.for_git_hub_user(user).issues.open.count,
        total_commits: base_query.for_git_hub_user(user).commits.count,
        total_additions: base_query.for_git_hub_user(user).sum(:additions),
        total_deletions: base_query.for_git_hub_user(user).sum(:deletions),
      }
    end

    def oc_averages
      {
        average_commits_per_user: GitHubStatistic.average_commits_prs_per_user,
        average_closed_prs_per_user: GitHubStatistic.average_closed_prs_per_user,
      }
    end

    def totals_for_user_in_repository
      user = GitHubUser.find_by(git_hub_login: params[:git_hub_login])
      repo = params[:repository]

      raise 'Could not find a user with that GitHub login.' unless user
      raise 'Could not find that OperationCode repository.' unless repo.present?

      {
        total_closed_pull_requests: user_in_repository(user, repo).pull_requests.count,
        total_open_issues: user_in_repository(user, repo).issues.open.count,
        total_commits: user_in_repository(user, repo).commits.count,
        total_additions: user_in_repository(user, repo).sum(:additions),
        total_deletions: user_in_repository(user, repo).sum(:deletions),
      }
    end

    private

    def base_query
      GitHubStatistic.date_range(default_dates)
    end

    def user_in_repository(user, repo)
      base_query.for_git_hub_user(user).for_repository(repo)
    end

    def default_dates
      defaults = { start_date: '1970-01-01', end_date: Date.today.to_s }
      defaults[:start_date] = params[:start_date] if params[:start_date].present?
      defaults[:end_date] = params[:end_date] if params[:end_date].present?
      defaults
    end
  end
end
