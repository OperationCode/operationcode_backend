module GitHub
  class PullRequests
    attr_reader :client, :compiled_pull_requests, :existing_pr_ids, :date

    def initialize
      @client = GitHub::Client.new
      @compiled_pull_requests = []
      @existing_pr_ids = GitHubStatistic.pull_requests.pluck(:source_id)
      @date = GitHubStatistic.last_pr_completed_on
    end

    def fetch_and_save!
      get_pull_requests.each do |pr|
        git_hub_user = GitHub::Committer.find_or_create_user! pr[:git_hub_user]

        GitHub::Committer.find_or_create_statistic! pr, pr[:source_type], git_hub_user.id
      end
    end

    private

    def get_pull_requests
      client.repositories.each do |repo|
        build_details_for repo
      end

      compiled_pull_requests
    end

    def build_details_for(repo)
      get_all_prs_for(repo).each do |pr|
        next if existing_pr_ids.include? pr['id'].to_s

        add_pull_request(repo, pr['number'])
        add_commits(repo, pr['number'])
      end
    end

    def get_all_prs_for(repo)
      query = {
        repo: repo,
        type: 'pr',
        is: 'merged',
        page_number: 1,
        filters: "+merged:>=#{date}"
      }
      response = client.search_for(query)

      if response.headers["link"].present?
        GitHub::PageCompiler.new(query, response, client).compile_prs
      else
        response['items']
      end
    end

    def add_pull_request(repo, pull_request_number)
      response = client.single_pull_request(repo, pull_request_number)

      compiled_pull_requests << GitHub::Structure.new(response.parsed_response, repo).pull_request
    end

    def add_commits(repo, pull_request_number)
      commit_responses = get_all_commits_for(repo, pull_request_number)

      commit_responses.each do |response|
        next unless author_present?(response)

        compiled_pull_requests << GitHub::Structure.new(response, repo).commit
      end
    end

    def get_all_commits_for(repo, pull_request_number)
      response = client.commits_for(repo, pull_request_number)
      query    = { repo: repo, pr_number: pull_request_number }

      if response.headers["link"].present?
        GitHub::PageCompiler.new(query, response, client).compile_commits
      else
        response.parsed_response
      end
    end

    def author_present?(response)
      response['author'].present? && response['author']['login'].present?
    end
  end
end
