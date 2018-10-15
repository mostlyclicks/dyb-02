Recaptcha.configure do |config|
  #config.site_key  = ENV["RECAPTCHA_SITE_KEY"]
  #config.secret_key = ENV["RECAPTCHA_SECRECT_KEY"]
  config.site_key  = Rails.application.secrets.recaptcha_site_key
  config.secret_key = Rails.application.secrets.recaptcha_secret_key
end