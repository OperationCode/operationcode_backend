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

    assert compiled_prs.size == 249
    assert compiled_prs.class == Array
    assert pr.class.to_s == 'Hash'
    assert pr['html_url'] == "https://github.com/OperationCode/operationcode/pull/2"
    assert pr['id'] == 66372782
    assert pr['number'] == 2
    assert pr['title'] == "Ignore OSX system files"
    assert pr['state'] == "closed"
  end
end
