require_relative 'minitest_helper'

describe ChromeData do
  before { ChromeData.remove_class_variable :@@config if ChromeData.class_variable_defined? :@@config }

  it 'yields configuration object to block' do
    ChromeData.configure do |config|
      config.account_number = 'foo123'
    end

    _(ChromeData.config.account_number).must_equal 'foo123'
  end
end
