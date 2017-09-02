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
        git_hub_user: {
          login: response['user']['login'],
          avatar_url: response['user']['avatar_url'],
          api_url: response['user']['url'],
          html_url: response['user']['html_url'],
          id: response['user']['id'],
        }
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
        git_hub_user: {
          login: response['author']['login'],
          avatar_url: response['author']['avatar_url'],
          api_url: response['author']['url'],
          html_url: response['author']['html_url'],
          id: response['author']['id'],
        }
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
        git_hub_user: {
          login: response['assignee']['login'],
          avatar_url: response['assignee']['avatar_url'],
          api_url: response['assignee']['url'],
          html_url: response['assignee']['html_url'],
          id: response['assignee']['id'],
        }
      }
    end
  end
end
