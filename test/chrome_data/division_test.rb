require_relative '../minitest_helper'

describe ChromeData::Division do
  include WsdlCassette
  include ConfigureApiAccess

  it 'returns a proper request name' do
    _(ChromeData::Division.request_name).must_equal 'getDivisions'
  end

  describe '.find_all_by_year' do
    before do
      configure_api_access
    end

    def find_divisions
      use_wsdl_cassette do
        VCR.use_cassette('2013/divisions') do
          @divisions = ChromeData::Division.find_all_by_year(2013)
        end
      end
    end

    it 'returns array of Division objects' do
      find_divisions

      _(@divisions.first).must_be_instance_of ChromeData::Division
      _(@divisions.size).must_equal 43
    end

    it 'sets ID on Division objects' do
      find_divisions

      _(@divisions.first.id).must_equal 1
    end

    it 'sets name on Division objects' do
      find_divisions

      _(@divisions.first.name).must_equal 'Acura'
    end

    it 'caches with proper key' do
      ChromeData.expects(:cache).with('get_divisions-model_year-2013')

      find_divisions
    end
  end

  describe '#models_for_year' do
    it 'finds models for given year and Division ID' do
      ChromeData::Model.expects(:find_all_by_year_and_division_id).with(2013, 13)

      ChromeData::Division.new(id: 13, name: 'Ford').models_for_year 2013
    end
  end
end
