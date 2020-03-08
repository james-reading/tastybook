if ENV['BUGSNAG_API_KEY'] && Rails.env.production?
  Bugsnag.configure do |config|
    config.api_key = ENV['BUGSNAG_API_KEY']
  end
end
