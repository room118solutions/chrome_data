require "chrome_data/version"
require "chrome_data/caching"
require "chrome_data/base_request"
require "chrome_data/collection_request"
require "chrome_data/config"
require "chrome_data/division"
require "chrome_data/model"
require "chrome_data/style"
require "chrome_data/model_year"
require "chrome_data/vehicle"

require 'active_support/notifications'
require 'active_support/cache'
require 'active_support/core_ext/hash/reverse_merge'

module ChromeData
  extend Caching
  extend self

  def configure
    yield config
  end

  def config
    @@config ||= Config.new
  end
end

