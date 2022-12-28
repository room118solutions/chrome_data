module ConfigureApiAccess
  def configure_api_access
    ChromeData.configure do |config|
      config.account_number = ENV.fetch('ACCOUNT_NUMBER', '123456')
      config.account_secret = ENV.fetch('ACCOUNT_SECRET', '1111111111111111')
    end
  end
end
