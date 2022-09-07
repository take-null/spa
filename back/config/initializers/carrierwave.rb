if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.asset_host = "http://localhost:3000"
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.s3[:aws_access_key_id],
      aws_secret_access_key: Rails.application.credentials.s3[:aws_secret_access_key],
      region: 'ap-northeast-1'
    }
  
    config.fog_directory  = Rails.application.credentials.s3[:fog_directory]
    config.cache_storage = :fog
  end
end