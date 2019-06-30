require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production? || Rails.env.staging?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require "selenium/webdriver"
require "webdrivers/chromedriver"
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Capybara.asset_host = 'http://localhost:5000'
Capybara::Screenshot.prune_strategy = { keep: 20 }

# This line does not really make sense but was suggested here: https://github.com/titusfortner/webdrivers/issues/126
Webdrivers::Chromedriver.required_version = '74.0.3729.6'

Capybara.register_driver :selenium_chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: { browser: 'ALL' },
    chromeOptions: {
      args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage disable-infobars disable-extensions window-size=1600,3200]
    }
  )

  service = Selenium::WebDriver::Service.chrome
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    service: service
  )
end

Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
end
