require 'vcr'

driver_hosts = Webdrivers::Common.subclasses.map do |driver|
  URI(driver.base_url).host
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.ignore_hosts(*driver_hosts)
end
