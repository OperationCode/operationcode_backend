require 'test_helper'

class ClientTest < Minitest::Test
  def setup
    @client = GitHub::Client.new
    @oc = GitHub::Settings::OC
    @pr_number = 753
  end

  def test_successful_search_for_prs_for_multi_page
    query = {
      repo: GitHub::Settings::OC,
      type: 'pr',
      is: 'merged',
      page_number: 1,
      filters: '+merged:>=1970-01-01'
    }

    response = VCR.use_cassette('git_hub/search/pull_requests/success_for_multi_page') do
      @client.search_for(query)
    end

    pr = response['items'].first

    ## link presence means there are multiple pages of results
    assert response.headers['link'].present?
    assert response['items'].present?
    assert response.code.to_i == 200
    assert pr['html_url'] == "https://github.com/OperationCode/operationcode/pull/753"
    assert pr['id'] == 240032714
    assert pr['number'] == @pr_number
    assert pr['title'] == "Revert \"waffle.io Badge\""
    assert pr['state'] == "closed"
  end

  def test_successful_search_for_prs_for_single_page
    query = {
      repo: GitHub::Settings::SLASHBOT,
      type: 'pr',
      is: 'merged',
      page_number: 1,
      filters: '+merged:>=1970-01-01'
    }

    response = VCR.use_cassette('git_hub/search/pull_requests/success_for_single_page') do
      @client.search_for(query)
    end

    pr = response['items'].first

    ## link absence means there is only one page of results
    assert response.headers['link'].present? == false
    assert response['items'].present?
    assert response.code.to_i == 200
    assert pr['html_url'] == "https://github.com/OperationCode/operationcode_slashbot/pull/7"
    assert pr['id'] == 221728378
    assert pr['number'] == 7
    assert pr['title'] == "Add /android case"
    assert pr['state'] == "closed"
  end

  def test_successful_search_for_issues
    query = {
      repo: GitHub::Settings::BACKEND,
      type: 'issue',
      is: 'closed',
      page_number: 1,
      filters: '+closed:>=1970-01-01'
    }

    response = VCR.use_cassette('git_hub/search/issues/successful') do
      @client.search_for(query)
    end

    issue = response['items'].first

    ## link absence means there is only one page of results
    assert response.headers['link'].present? == false
    assert response['items'].present?
    assert response['items'].size == 59
    assert response.code.to_i == 200
    assert issue['html_url'] == 'https://github.com/OperationCode/operationcode_backend/issues/140'
    assert issue['id'] == 250032036
    assert issue['number'] == 140
    assert issue['title'] == "Correct the spelling for 'distributions' in the contribution guide"
    assert issue['state'] == "closed"
  end

  def test_successful_single_pull_request
    response = VCR.use_cassette('git_hub/pull_request/successful') do
      @client.single_pull_request(@oc, @pr_number)
    end

    pr = response.parsed_response

    assert pr['id'] == 128533020
    assert pr['number'] == 753
    assert pr['additions'] == 0
    assert pr['deletions'] == 3
    assert pr['html_url'] == 'https://github.com/OperationCode/operationcode/pull/753'
    assert pr['title'] == "Revert \"waffle.io Badge\""
    assert pr['merged_at'] == '2017-07-02T20:32:11Z'

    assert pr['user']['login'] == 'hollomancer'
    assert pr['user']['avatar_url'] == 'https://avatars3.githubusercontent.com/u/9288648?v=4'
    assert pr['user']['url'] == 'https://api.github.com/users/hollomancer'
    assert pr['user']['html_url'] == 'https://github.com/hollomancer'
    assert pr['user']['id'] == 9288648
  end

  def test_successful_commits_for
    response = VCR.use_cassette('git_hub/commits/successful') do
      @client.commits_for(@oc, @pr_number, 1)
    end

    commit = response.parsed_response.first

    assert response.headers['link'].nil?
    assert response.parsed_response.class == Array
    assert response.parsed_response.size == 1
    assert commit['sha'] == '3d4ff7164a33fa1c6006d34942872d1c22594b99'
    assert commit['html_url'] == 'https://github.com/OperationCode/operationcode/commit/3d4ff7164a33fa1c6006d34942872d1c22594b99'
    assert commit['commit']['message'] == "Revert \"waffle.io Badge (#752)\"\n\nThis reverts commit ac38898ddeae5ddd17cdb6addba1b52fc6da923a."
    assert commit['commit']['committer']['date'] == '2017-07-02T20:31:56Z'

    assert commit['author']['login'] == 'hollomancer'
    assert commit['author']['avatar_url'] == 'https://avatars3.githubusercontent.com/u/9288648?v=4'
    assert commit['author']['url'] == 'https://api.github.com/users/hollomancer'
    assert commit['author']['html_url'] == 'https://github.com/hollomancer'
    assert commit['author']['id'] == 9288648
  end

  def test_rate_limit_presence
    response = VCR.use_cassette('git_hub/commits/successful') do
      @client.commits_for(@oc, @pr_number, 1)
    end

    assert response.headers['X-RateLimit-Remaining'] == '57'
    assert response.headers['X-RateLimit-Limit'] == '60'
    assert response.headers['X-RateLimit-Reset'] == '1503866476'
    assert @client.send(:reset_time, response) == '8/27/2017 at 8:41:16pm UTC'
  end
end
