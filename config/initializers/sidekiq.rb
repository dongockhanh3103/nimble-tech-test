Sidekiq.configure_server do |config|
  config.redis = GlobalSetting.redis_config(Settings.SIDEKIQ_DB)

  # when a job is death, delete its lock digest to prevent deadlock
  config.death_handlers << ->(job, _ex) do
    SidekiqUniqueJobs::Digests.del(digest: job['unique_digest']) if job['unique_digest']
  end
end

Sidekiq.configure_client do |config|
  config.redis = GlobalSetting.redis_config(Settings.SIDEKIQ_DB)
end

Sidekiq::Extensions.enable_delay!
