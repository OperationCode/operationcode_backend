module GitHub
  class PageCompiler
    attr_reader :search_params, :response, :page_count, :client

    # @see https://developer.github.com/v3/guides/traversing-with-pagination/#consuming-the-information
    #
    def initialize(search_params, response, client)
      @search_params = search_params
      @response = response
      @page = 2
      @page_count = pages_in(response) - 1
      @client = client
    end

    def compile_prs
      compiled_prs = response['items']

      page_count.times do
        pr_response = client.search_for(search_params.merge({ page_number: @page }))

        compiled_prs << pr_response['items']

        @page += 1
      end

      compiled_prs.flatten
    end

    def compile_commits
      compiled_commits = response.parsed_response

      page_count.times do
        response << client.commits_for(search_params[:repo], search_params[:pr_number], @page)

        compiled_commits << response.parsed_response

        @page += 1
      end

      compiled_commits.flatten
    end

    private

    def pages_in(response)
      pages = response.headers["link"].split(",").last.match(/&page=(\d+).*$/)[1]

      pages.to_i
    end
  end
end
