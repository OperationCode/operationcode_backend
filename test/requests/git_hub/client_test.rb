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
    assert_equal 200, response.code.to_i
    assert_equal 'https://github.com/OperationCode/operationcode/pull/753', pr['html_url']
    assert_equal 240032714, pr['id']
    assert_equal @pr_number, pr['number']
    assert_equal 'Revert "waffle.io Badge"', pr['title']
    assert_equal 'closed', pr['state']
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
    refute response.headers['link'].present?
    assert response['items'].present?
    assert_equal 200, response.code.to_i
    assert_equal 'https://github.com/OperationCode/operationcode_slashbot/pull/7', pr['html_url']
    assert_equal 221728378, pr['id']
    assert_equal 7, pr['number']
    assert_equal 'Add /android case', pr['title']
    assert_equal 'closed', pr['state']
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
    refute response.headers['link'].present?
    assert response['items'].present?
    assert_equal 59, response['items'].size
    assert_equal 200, response.code.to_i
    assert_equal 'https://github.com/OperationCode/operationcode_backend/issues/140', issue['html_url']
    assert_equal 250032036, issue['id']
    assert_equal 140, issue['number']
    assert_equal "Correct the spelling for 'distributions' in the contribution guide", issue['title']
    assert_equal 'closed', issue['state']
  end

  def test_successful_single_pull_request
    response = VCR.use_cassette('git_hub/pull_request/successful') do
      @client.single_pull_request(@oc, @pr_number)
    end

    pr = response.parsed_response

    assert_equal 128533020, pr['id']
    assert_equal 753, pr['number']
    assert_equal 0, pr['additions']
    assert_equal 3, pr['deletions']
    assert_equal 'https://github.com/OperationCode/operationcode/pull/753', pr['html_url']
    assert_equal 'Revert "waffle.io Badge"', pr['title']
    assert_equal '2017-07-02T20:32:11Z', pr['merged_at']

    assert_equal 'hollomancer', pr['user']['login']
    assert_equal 'https://avatars3.githubusercontent.com/u/9288648?v=4', pr['user']['avatar_url']
    assert_equal 'https://api.github.com/users/hollomancer', pr['user']['url']
    assert_equal 'https://github.com/hollomancer', pr['user']['html_url']
    assert_equal 9288648, pr['user']['id']
  end

  def test_successful_commits_for
    response = VCR.use_cassette('git_hub/commits/successful') do
      @client.commits_for(@oc, @pr_number, 1)
    end

    commit = response.parsed_response.first

    assert response.headers['link'].nil?
    assert_equal Array, response.parsed_response.class
    assert_equal 1, response.parsed_response.size
    assert_equal '3d4ff7164a33fa1c6006d34942872d1c22594b99', commit['sha']
    assert_equal 'https://github.com/OperationCode/operationcode/commit/3d4ff7164a33fa1c6006d34942872d1c22594b99', commit['html_url']
    assert_equal "Revert \"waffle.io Badge (#752)\"\n\nThis reverts commit ac38898ddeae5ddd17cdb6addba1b52fc6da923a.", commit['commit']['message']
    assert_equal '2017-07-02T20:31:56Z', commit['commit']['committer']['date']

    assert_equal 'hollomancer', commit['author']['login']
    assert_equal 'https://avatars3.githubusercontent.com/u/9288648?v=4', commit['author']['avatar_url']
    assert_equal 'https://api.github.com/users/hollomancer', commit['author']['url']
    assert_equal 'https://github.com/hollomancer', commit['author']['html_url']
    assert_equal 9288648, commit['author']['id']
  end

  def test_rate_limit_presence
    response = VCR.use_cassette('git_hub/commits/successful') do
      @client.commits_for(@oc, @pr_number, 1)
    end

    reset_time = Time.at(1503866476).strftime '%-m/%d/%Y at%l:%M:%S%P %Z'

    assert_equal '57', response.headers['X-RateLimit-Remaining']
    assert_equal '60', response.headers['X-RateLimit-Limit']
    assert_equal '1503866476', response.headers['X-RateLimit-Reset']
    assert_equal reset_time, @client.send(:reset_time, response)
  end
end
