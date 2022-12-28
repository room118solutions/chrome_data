require_relative '../minitest_helper'

describe ChromeData::Model do
  include WsdlCassette
  include ConfigureApiAccess

  it 'returns a proper request name' do
    _(ChromeData::Model.request_name).must_equal 'getModels'
  end

  describe '.find_all_by_year_and_division_id' do
    before do
      configure_api_access
    end

    def find_models
      use_wsdl_cassette do
        VCR.use_cassette('2013/divisions/13/models') do
          @models = ChromeData::Model.find_all_by_year_and_division_id(2013, 13) # 2013 Fords
        end
      end
    end

    it 'returns array of Model objects' do
      find_models

      _(@models.first).must_be_instance_of ChromeData::Model
      _(@models.size).must_equal 39
    end

    it 'sets ID on Model objects' do
      find_models

      _(@models.first.id).must_equal 25459
    end

    it 'sets name on Model objects' do
      find_models

      _(@models.first.name).must_equal 'C-Max Energi'
    end

    it 'caches with proper key' do
      ChromeData.expects(:cache).with('get_models-model_year-2013-division_id-13')

      find_models
    end
  end

  describe '#styles' do
    it 'finds styles for Model' do
      ChromeData::Style.expects(:find_all_by_model_id).with(24997)

      ChromeData::Model.new(id: 24997, name: 'Mustang').styles
    end
  end
end
