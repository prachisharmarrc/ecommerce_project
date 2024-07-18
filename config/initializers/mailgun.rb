# config/initializers/mailgun.rb
Mailgun.configure do |config|
    config.api_key = ENV['MAILGUN_API_KEY']
  end
  
  MAILGUN_DOMAIN = ENV['MAILGUN_DOMAIN']
  MAILGUN_FROM_EMAIL = ENV['MAILGUN_FROM_EMAIL']
  