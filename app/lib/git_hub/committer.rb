module GitHub
  class Committer
    def self.find_or_create_user!(user_attrs)
      GitHubUser.find_or_create_by!(git_hub_id: user_attrs[:id]) do |user|
        user.git_hub_login = user_attrs[:login]
        user.avatar_url = user_attrs[:avatar_url]
        user.api_url = user_attrs[:api_url]
        user.html_url = user_attrs[:html_url]
      end
    end

    def self.find_or_create_statistic!(stat_attrs, source_type, git_hub_user_id)
      GitHubStatistic.find_or_create_by!(source_type: source_type, source_id: stat_attrs[:id]) do |stat|
        stat.git_hub_user_id = git_hub_user_id
        stat.state = stat_attrs[:state]
        stat.additions = stat_attrs[:additions].to_i
        stat.deletions = stat_attrs[:deletions].to_i
        stat.repository = stat_attrs[:repository]
        stat.url = stat_attrs[:url]
        stat.title = stat_attrs[:title]
        stat.number = stat_attrs[:number]
        stat.completed_on = stat_attrs[:closed_on]
      end
    end
  end
end
