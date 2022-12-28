require_relative '../minitest_helper'

describe ChromeData::Style do
  include WsdlCassette
  include ConfigureApiAccess

  it 'returns a proper request name' do
    _(ChromeData::Style.request_name).must_equal 'getStyles'
  end

  describe '.find_all_by_model_id' do
    before do
      configure_api_access
    end

    def find_styles
      use_wsdl_cassette do
        VCR.use_cassette('2013/divisions/13/models/24997/styles') do
          @models = ChromeData::Style.find_all_by_model_id(24997) # 2013 Ford Mustang
        end
      end
    end

    it 'returns array of Style objects' do
      find_styles

      _(@models.first).must_be_instance_of ChromeData::Style
      _(@models.size).must_equal 11
    end

    it 'sets ID on Style objects' do
      find_styles

      _(@models.first.id).must_equal 349411
    end

    it 'sets name on Style objects' do
      find_styles

      _(@models.first.name).must_equal '2dr Conv GT'
    end

    it 'caches with proper key' do
      ChromeData.expects(:cache).with('get_styles-model_id-24997')

      find_styles
    end
  end
end
