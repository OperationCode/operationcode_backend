require 'test_helper'

class GitHub::PageCompilerTest < Minitest::Test
  def setup
    @client = GitHub::Client.new
  end

  def test_for_compile_prs
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

    compiled_prs = VCR.use_cassette('git_hub/search/pull_requests/compile_prs') do
      GitHub::PageCompiler.new(query, response, @client).compile_prs
    end

    pr = compiled_prs.last

    assert_equal 249, compiled_prs.size
    assert_equal Array, compiled_prs.class
    assert_equal Hash, pr.class
    assert_equal 'https://github.com/OperationCode/operationcode/pull/2', pr['html_url']
    assert_equal 66372782, pr['id']
    assert_equal 2, pr['number']
    assert_equal 'Ignore OSX system files', pr['title']
    assert_equal 'closed', pr['state']
  end
end
