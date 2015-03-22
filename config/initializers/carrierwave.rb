CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["SUPERTIGER_AWS_ACCES_KEY_ID"],                        # required
    :aws_secret_access_key  => ENV["SUPERTIGER_AWS_SECRET_ACCESS_KEY"],                        # required
    :region                 => 'eu-west-1'                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'supertiger'                          # required
  config.fog_public     = true                                        # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end