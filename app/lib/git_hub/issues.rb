module GitHub
  class Issues
    attr_reader :client, :compiled_issues, :existing_issue_ids, :date

    def initialize
      @client = GitHub::Client.new
      @compiled_issues = []
      @existing_issue_ids = GitHubStatistic.issues.pluck(:source_id)
      @date = GitHubStatistic.last_issue_completed_on
    end

    def fetch_and_save!
      get_issues.each do |issue|
        git_hub_user = GitHub::Committer.find_or_create_user! issue[:git_hub_user]

        GitHub::Committer.find_or_create_statistic! issue, issue[:source_type], git_hub_user.id
      end
    end

    private

    def get_issues
      client.repositories.each do |repo|
        build_details_for repo
      end

      compiled_issues
    end

    def build_details_for(repo)
      get_all_issues_for(repo).each do |issue|
        next if existing_issue_ids.include? issue['id'].to_s
        next unless assignee_present? issue

        compiled_issues << GitHub::Structure.new(issue, repo).issue
      end
    end

    def get_all_issues_for(repo)
      query = {
        repo: repo,
        type: 'issue',
        is: 'closed',
        page_number: 1,
        filters: "+closed:>=#{date}"
      }
      response = client.search_for(query)

      if response.headers["link"].present?
        GitHub::PageCompiler.new(query, response, client).compile_prs
      else
        response['items']
      end
    end

    def assignee_present?(issue)
      issue['assignee'].present? && issue['assignee']['login'].present?
    end
  end
end
