require "httparty"

module GitHub

  # Hits GitHub's REST API v3 endpoints.
  #
  # @see https://developer.github.com/v3/
  #
  class Client
    include HTTParty
    base_uri 'api.github.com'

    attr_reader :commits, :issues, :repositories, :owner, :options

    def initialize
      @repositories = GitHub::Settings.repositories
      @owner = GitHub::Settings.owner
      @commits = []
      @issues = []
      @options = GitHub::Authentication.new(base_options).set_options
    end

    # Gets a list of pull requests or issues, that meet the passed in
    # search criteria.
    #
    # @param repo [String] Name of the repository
    # @param type [String] Either 'issue' or 'pr'
    # @param is [String] State of the item, either 'open', 'closed', or 'merged'
    # @param page_number [Integer] Page number to fetch results from. Only applies if there is more than 1 page of results.
    # @param filters [String] Optional string of additional search filters
    # @return [HTTParty::Response] HTTParty::Response object from the GitHub endpoint
    # @example Here is a sample completed query string:
    #   "q=type:pr+is:merged+repo:OperationCode/operationcode_backend+merged:>=2017-05-01"
    # @see For details on this endpoint and all its options:
    #   https://developer.github.com/v3/search/#search-issues
    #
    def search_for(repo: , type: 'pr', is: 'merged', page_number: 1, filters: '')
      query    = "q=type:#{type}+is:#{is}+repo:#{owner}/#{repo}#{filters}"
      response = self.class.get("/search/issues?#{query}", page_options(page_number))

      return_value_for response
    end

    # Hits GitHub's 'Get a single pull request' endpoint
    #
    # @see https://developer.github.com/v3/pulls/#get-a-single-pull-request
    #
    def single_pull_request(repo, pull_request_number)
      response = self.class.get("/repos/#{owner}/#{repo}/pulls/#{pull_request_number}", options)

      return_value_for response
    end

    # Hits GitHub's 'List commits on a pull request' endpoint
    #
    # @see https://developer.github.com/v3/pulls/#list-commits-on-a-pull-request
    #
    def commits_for(repo, pull_request_number, page_number=1)
      response = self.class.get("/repos/#{owner}/#{repo}/pulls/#{pull_request_number}/commits", page_options(page_number))

      return_value_for response
    end

    private

    def base_options
      {
        query: {
          per_page: GitHub::Settings.per_page,
        },
        headers: {
          'Accepts' => 'application/vnd.github.v3+json',
          'User-Agent' => GitHub::Settings.user_agent,
        },
      }
    end

    def page_options(page_number)
      page = {
        query: {
          page: page_number,
        }
      }

      page.deep_merge options
    end

    def return_value_for(response)
      if response.code.to_i == 200
        check_rate_limit(response)
        response
      else
        error_message = "GitHub::Client experienced this error: Status #{response.code}. #{response.parsed_response}"

        Rails.logger.error error_message
        raise error_message
      end
    end

    def check_rate_limit(response)
      return unless response.headers['X-RateLimit-Remaining'].to_s == '0'

      rate_limit    = response.headers['X-RateLimit-Limit']
      error_message = "Reached the rate limit. Limit: #{rate_limit}; Remaining: 0; Resets At: #{reset_time(response)}.  Visit https://developer.github.com/v3/#rate-limiting for details."

      Rails.logger.error error_message
      raise error_message
    end

    def reset_time(response)
      seconds = response.headers['X-RateLimit-Reset'].to_i

      Time.at(seconds).strftime "%-m/%d/%Y at%l:%M:%S%P %Z"
    end
  end
end
