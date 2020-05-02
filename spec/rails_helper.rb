require 'simplecov'
SimpleCov.start do
  add_filter 'config/'
end

ENV["RACK_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"
require "pundit/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include RequestSpecHelper, type: :request

  config.before(:suite) do
    Recipe.reindex
    Searchkick.disable_callbacks
  end

  config.around(:each, search: true) do |example|
    Searchkick.callbacks(true) do
      example.run
    end
  end
end

ActiveRecord::Migration.maintain_test_schema!
