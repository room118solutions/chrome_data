# Valid options:
#   account_number
#   account_secret
#   country (default: 'US')
#   language (default: 'en')
#   cache_store
module ChromeData
  class Config
    attr_accessor :account_number, :account_secret, :cache_store
    attr_writer :country, :language

    def country
      instance_variable_defined?(:@country) ? @country : 'US'
    end

    def language
      instance_variable_defined?(:@language) ? @language : 'en'
    end
  end
end
