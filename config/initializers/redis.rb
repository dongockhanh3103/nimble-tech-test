if Rails.env.test?
  require "fakeredis"

  REDIS = REDIS_SECURE = Redis.new
else
  REDIS = Redis.new(GlobalSetting.redis_config(Settings.REDIS_DB))

  # While REDIS can be used for wide range tasks, such as: caching,
  # store unimportant values, REDIS_SECURE is used to secret, important
  # values.
  REDIS_SECURE = Redis.new(GlobalSetting.redis_config(Settings.REDIS_SECURE_DB))
end