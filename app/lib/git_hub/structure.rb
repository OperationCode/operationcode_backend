module GitHub
  class Structure
    attr_reader :repository, :response

    def initialize(response, repository)
      @response = response
      @repository = repository
    end

    def pull_request
      {
        source_type: GitHubStatistic::PR,
        source_id: response['id'],
        repository: repository,
        number: response['number'],
        state: response['state'],
        additions: response['additions'],
        deletions: response['deletions'],
        url: response['html_url'],
        title: response['title'],
        closed_on: response['merged_at'].to_date,
        git_hub_user: append_git_hub_user('user')
      }
    end

    def commit
      {
        source_type: GitHubStatistic::COMMIT,
        source_id: response['sha'],
        url: response['html_url'],
        title: response['commit']['message'],
        repository: repository,
        closed_on: response['commit']['committer']['date'].to_date,
        git_hub_user: append_git_hub_user('author')
      }
    end

    def issue
      {
        source_type: GitHubStatistic::ISSUE,
        source_id: response['id'],
        url: response['html_url'],
        title: response['title'],
        number: response['number'],
        state: response['state'],
        repository: repository,
        closed_on: response['closed_at'].to_date,
        git_hub_user: append_git_hub_user('assignee')
      }
    end

  private

    def append_git_hub_user(user_key)
      {
        login: response[user_key]['login'],
        avatar_url: response[user_key]['avatar_url'],
        api_url: response[user_key]['url'],
        html_url: response[user_key]['html_url'],
        id: response[user_key]['id'],
      }
    end
  end
end
