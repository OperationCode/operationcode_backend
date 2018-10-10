require 'test_helper'

class IssuesTest < Minitest::Test
  def setup
    GitHubStatistic.delete_all
    GitHubUser.delete_all
    @issue_instance = GitHub::Issues.new
    @backend = GitHub::Settings::BACKEND
    client = GitHub::Client.new
    query = {
      repo: @backend,
      type: 'issue',
      is: 'closed',
      page_number: 1,
      filters: '+closed:>=1970-01-01'
    }

    @response = VCR.use_cassette('git_hub/search/issues/successful') do
      client.search_for(query)
    end

    stub_client_calls
  end

  def test_build_details_for
    @issue_instance.send(:build_details_for, @backend)

    issues_assertions
  end

  def test_get_issues
    @issue_instance.send(:get_issues)

    issues_assertions
  end

  def test_fetch_and_save
    @issue_instance.fetch_and_save!(print_results: false)

    assert_equal 28, GitHubStatistic.for_repository(@backend).count
    assert_equal 28, GitHubStatistic.for_repository(@backend).issues.count
    assert_equal 28, GitHubStatistic.for_repository(@backend).pluck(:title).uniq.count
    assert_equal 28, GitHubStatistic.for_repository(@backend).pluck(:number).uniq.count
    assert_equal 4, GitHubUser.count
  end

  def stub_client_calls
    @issue_instance.client.stubs(:repositories).returns([@backend])
    @issue_instance.stubs(:get_all_issues_for).with(@backend).returns(@response['items'])
  end

  def issues_assertions
    assert_equal 28, @issue_instance.compiled_issues.size
    assert_equal ['Issue'], @issue_instance.compiled_issues.map { |stat| stat[:source_type] }.uniq
    assert_equal ['closed'], @issue_instance.compiled_issues.map { |stat| stat[:state] }.uniq
    assert_equal ['operationcode_backend'], @issue_instance.compiled_issues.map { |stat| stat[:repository] }.uniq
    assert_equal 'https://github.com/OperationCode/operationcode_backend/issues/133', @issue_instance.compiled_issues.first[:url]
    assert_equal 'Support for multi step profiles', @issue_instance.compiled_issues.first[:title]
    assert_equal 133, @issue_instance.compiled_issues.first[:number]
    assert_equal 248273181, @issue_instance.compiled_issues.first[:source_id]
  end
end
