$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'chrome_data'

require 'minitest/autorun'
require 'mocha/minitest'
require 'vcr'

# Require all support files
Dir["test/support/**/*.rb"].each { |f| require_relative "../#{f}" }

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    match_requests_on: [:method, :uri, :body],
    record: :new_episodes
  }

  c.filter_sensitive_data('<ACCOUNT_NUMBER>') { ChromeData.config.account_number }
  c.filter_sensitive_data('<ACCOUNT_SECRET>') { ChromeData.config.account_secret }
end
