# frozen_string_literal: true

module GlobalSetting

  # @return [Hash] configuration of redis which used for caching store.
  #   This config is specific for each environment.
  def self.redis_store_config
    redis_config(Settings.REDIS_STORE_DB).merge(
      expires_in: 90.minutes
    )
  end

  # @return [Object] Redis config
  def self.redis_config(db)
    uri = URI.parse(redis_url)

    {
      host:     uri.host,
      port:     uri.port,
      password: uri.password,
      db:       db
    }
  end

  # @return [String] Redis database url
  def self.redis_url
    Settings.REDIS_URL
  end

end
