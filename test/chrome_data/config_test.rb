require_relative '../minitest_helper'

describe ChromeData::Config do
  let(:config) { ChromeData::Config.new }

  it 'uses default value for country, but it can be overridden' do
    _(config.country).must_equal 'US'

    config.country = 'GB'

    _(config.country).must_equal 'GB'
  end

  it 'uses default value for language, but it can be overridden' do
    _(config.language).must_equal 'en'

    config.language = 'es'

    _(config.language).must_equal 'es'
  end
end
