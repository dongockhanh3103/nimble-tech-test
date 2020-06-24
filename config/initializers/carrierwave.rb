if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage           = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage         = :aws
    config.aws_acl         = 'public-read'
    config.aws_bucket      = Settings.s3_asset.hostname
    config.aws_credentials = {
      region:            Settings.s3_asset.region,
      endpoint:          Settings.s3_asset.endpoint,
      access_key_id:     Settings.s3_asset.access_key_id,
      secret_access_key: Settings.s3_asset.secret_access_key
    }

    s3_url = Settings.s3_asset.url

    if s3_url
      config.asset_host = s3_url
    end
  end
end
