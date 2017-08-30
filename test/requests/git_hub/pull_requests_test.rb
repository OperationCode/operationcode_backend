require 'test_helper'

class PullRequestsTest < Minitest::Test
  def setup
    GitHubStatistic.delete_all
    GitHubUser.delete_all
    @pr_instance = GitHub::PullRequests.new
    @slash = GitHub::Settings::SLASHBOT
    client = GitHub::Client.new
    query = {
      repo: @slash,
      type: 'pr',
      is: 'merged',
      page_number: 1,
      filters: '+merged:>=1970-01-01'
    }

    @search_response = VCR.use_cassette('git_hub/search/pull_requests/success_for_single_page') do
      client.search_for(query)
    end

    @pr_6_response = VCR.use_cassette('git_hub/pull_request/slashbot/pr_6') do
      client.single_pull_request(@slash, 6)
    end

    @pr_7_response = VCR.use_cassette('git_hub/pull_request/slashbot/pr_7') do
      client.single_pull_request(@slash, 7)
    end

    @commit_6_response = VCR.use_cassette('git_hub/commits/slashbot/pr_6') do
      client.commits_for(@slash, 6)
    end

    @commit_7_response = VCR.use_cassette('git_hub/commits/slashbot/pr_7') do
      client.commits_for(@slash, 7)
    end

    stub_client_calls
  end

  def test_build_details_for
    @pr_instance.send(:build_details_for, @slash)

    pull_requests_assertions
  end

  def test_get_pull_requests
    @pr_instance.send(:get_pull_requests)

    pull_requests_assertions
  end

  def test_fetch_and_save
    @pr_instance.fetch_and_save!

    assert GitHubStatistic.for_repository(@slash).count == 4
    assert GitHubStatistic.for_repository(@slash).pull_requests.count == 2
    assert GitHubStatistic.for_repository(@slash).commits.count == 2
    assert GitHubUser.count == 2
    assert GitHubStatistic.for_repository(@slash).pull_requests.find_by(number: @pr_6_response.parsed_response['number'].to_s)
    assert GitHubStatistic.for_repository(@slash).pull_requests.find_by(number: @pr_7_response.parsed_response['number'].to_s)
  end

  def stub_client_calls
    @pr_instance.client.stubs(:repositories).returns([@slash])
    @pr_instance.stubs(:get_all_prs_for).with(@slash).returns(@search_response['items'])
    @pr_instance.client.stubs(:single_pull_request).with(@slash, 6).returns(@pr_6_response)
    @pr_instance.client.stubs(:single_pull_request).with(@slash, 7).returns(@pr_7_response)
    @pr_instance.client.stubs(:commits_for).with(@slash, 6).returns(@commit_6_response)
    @pr_instance.client.stubs(:commits_for).with(@slash, 7).returns(@commit_7_response)
  end

  def pull_requests_assertions
    assert @pr_instance.compiled_pull_requests.size == 4
    assert @pr_instance.compiled_pull_requests.first[:source_type] == 'PullRequest'
    assert @pr_instance.compiled_pull_requests.first[:number] == 7
    assert @pr_instance.compiled_pull_requests.first[:repository] == 'operationcode_slashbot'

    assert @pr_instance.compiled_pull_requests.second[:source_type] == 'Commit'
    assert @pr_instance.compiled_pull_requests.second[:title] == "Add /android case"

    assert @pr_instance.compiled_pull_requests.third[:source_type] == 'Commit'
    assert @pr_instance.compiled_pull_requests.third[:title] == "Change environment variable for node"

    assert @pr_instance.compiled_pull_requests.last[:source_type] == 'PullRequest'
    assert @pr_instance.compiled_pull_requests.last[:number] == 6
  end
end
