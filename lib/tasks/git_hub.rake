namespace :git_hub do
  desc "Saves pull request, commit, issue and user details for all repositories to date, to GitHubStatistic and GitHubUser"
  task collect_statistics: :environment do
    begin
      GitHub::PullRequests.new.fetch_and_save!
      GitHub::Issues.new.fetch_and_save!
    rescue => e
      Rails.logger.error "When fetching and saving GitHub statistics, experienced this error: #{e}"
    end
  end
end
