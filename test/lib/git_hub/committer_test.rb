require 'test_helper'

class GitHub::CommitterTest < ActiveSupport::TestCase
  setup do
    GitHubStatistic.delete_all
    GitHubUser.delete_all

    @user_attrs = {
      user_id: nil,
      login: 'jack',
      avatar_url: 'https://avatars3.githubusercontent.com/u/123456?v=4',
      api_url: 'https://api.github.com/users/jack',
      html_url: 'https://github.com/jack',
    }

    @stat_attrs = {
      source_id: '128533020',
      source_type: 'PullRequest',
      state: 'closed',
      additions: 100,
      deletions: 3,
      repository: 'operationcode',
      url: 'https://api.github.com/repos/OperationCode/operationcode/pulls/753',
      title: 'Fix this that and the other thing',
      number: '753',
      closed_on: '2017-7-02'
    }
  end

  test ".find_or_create_user! creates and returns non-existing GitHubUser" do
    assert GitHubUser.count == 0

    user = GitHub::Committer.find_or_create_user! @user_attrs

    assert GitHubUser.first == user
  end

  test ".find_or_create_user! returns the existing matched user" do
    user    = create :git_hub_user, git_hub_login: @user_attrs[:login]
    results = GitHub::Committer.find_or_create_user! @user_attrs.merge(id: user.git_hub_id)

    assert results == user
  end

  test ".find_or_create_statistic! creates and returns non-existing GitHubStatistic" do
    assert GitHubStatistic.count == 0

    stat = GitHub::Committer.find_or_create_statistic!(
      @stat_attrs,
      @stat_attrs[:source_type],
      create(:git_hub_user).id
    )

    assert GitHubStatistic.first == stat
  end

  test ".find_or_create_statistic! returns the existing matched user" do
    user = create :git_hub_user
    stat = create(
      :git_hub_statistic,
      source_id: @stat_attrs[:source_id],
      source_type: @stat_attrs[:source_type]
    )

    results = GitHub::Committer.find_or_create_statistic!(
      @stat_attrs.merge(id: stat.source_id),
      stat.source_type,
      user.git_hub_id
    )

    assert results == stat
  end
end
