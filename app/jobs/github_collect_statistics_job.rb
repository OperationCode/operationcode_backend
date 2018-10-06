class GithubCollectStatisticsJob
  include Sidekiq::Worker

  def perform
    limit = GitHub::Client.new.rate_limit
    logger.info("Github Ratelimit: #{limit}")

    GitHub::PullRequests.new.fetch_and_save!
    GitHub::Issues.new.fetch_and_save!
  end
end
