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
    @issue_instance.fetch_and_save!

    assert GitHubStatistic.for_repository(@backend).count == 28
    assert GitHubStatistic.for_repository(@backend).issues.count == 28
    assert GitHubStatistic.for_repository(@backend).pluck(:title).uniq.count == 28
    assert GitHubStatistic.for_repository(@backend).pluck(:number).uniq.count == 28
    assert GitHubUser.count == 4
  end

  def stub_client_calls
    @issue_instance.client.stubs(:repositories).returns([@backend])
    @issue_instance.stubs(:get_all_issues_for).with(@backend).returns(@response['items'])
  end

  def issues_assertions
    assert @issue_instance.compiled_issues.size == 28
    assert @issue_instance.compiled_issues.map { |stat| stat[:source_type] }.uniq == ['Issue']
    assert @issue_instance.compiled_issues.map { |stat| stat[:state] }.uniq == ['closed']
    assert @issue_instance.compiled_issues.map { |stat| stat[:repository] }.uniq == ['operationcode_backend']
    assert @issue_instance.compiled_issues.first[:url] == 'https://github.com/OperationCode/operationcode_backend/issues/133'
    assert @issue_instance.compiled_issues.first[:title] == 'Support for multi step profiles'
    assert @issue_instance.compiled_issues.first[:number] == 133
    assert @issue_instance.compiled_issues.first[:id] == 248273181
  end
end
