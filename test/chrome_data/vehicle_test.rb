require_relative '../minitest_helper'

describe ChromeData::Vehicle do
  include WsdlCassette
  include ConfigureApiAccess

  it 'returns a proper request name' do
    _(ChromeData::Vehicle.request_name).must_equal 'describeVehicle'
  end

  describe '.find_by_vin' do
    before do
      configure_api_access

      use_wsdl_cassette do
        VCR.use_cassette('vehicles/WDDGF4HB1CR000000') do
          @vehicle = ChromeData::Vehicle.find_by_vin('WDDGF4HB1CR000000')
        end
      end
    end

    it 'returns a Vehicle object' do
      _(@vehicle).must_be_instance_of ChromeData::Vehicle
    end

    it 'sets model year on Vehicle' do
      _(@vehicle.model_year).must_equal 2012
    end

    it 'sets division and vidision_id on Vehicle' do
      _(@vehicle.division).must_equal 'Mercedes-Benz'
      _(@vehicle.division_id).must_equal 27
    end

    it 'sets model and model_id on Vehicle' do
      _(@vehicle.model).must_equal 'C-Class'
      _(@vehicle.model_id).must_equal 21771
    end

    describe 'styles' do
      it 'sets id' do
        _(@vehicle.styles[0].id).must_equal 337364
        _(@vehicle.styles[1].id).must_equal 337365
      end

      it 'sets name' do
        _(@vehicle.styles[0].name).must_equal '4dr Sdn C 250 Sport RWD'
        _(@vehicle.styles[1].name).must_equal '4dr Sdn C 250 Luxury RWD'
      end

      it 'sets trim' do
        _(@vehicle.styles[0].trim).must_equal 'C 250 Sport'
        _(@vehicle.styles[1].trim).must_equal 'C 250 Luxury'
      end

      it 'sets name_without_trim' do
        _(@vehicle.styles[0].name_without_trim).must_equal '4dr Sdn RWD'
        _(@vehicle.styles[1].name_without_trim).must_equal '4dr Sdn RWD'
      end

      describe 'body_types' do
        it 'sets name' do
          _(@vehicle.styles[0].body_types[0].name).must_equal '4dr Car'
          _(@vehicle.styles[1].body_types[0].name).must_equal '4dr Car'
        end

        it 'sets id' do
          _(@vehicle.styles[0].body_types[0].id).must_equal 2
          _(@vehicle.styles[1].body_types[0].id).must_equal 2
        end
      end
    end

    describe 'engines' do
      it 'sets type' do
        _(@vehicle.engines[0].type).must_equal '4 Cylinder Engine'
      end
    end
  end

  describe '.find_by_style_id' do
    before do
      configure_api_access

      use_wsdl_cassette do
        VCR.use_cassette('vehicles/387520') do
          @vehicle = ChromeData::Vehicle.find_by_style_id('387520')
        end
      end
    end

    it 'returns a Vehicle object' do
      _(@vehicle).must_be_instance_of ChromeData::Vehicle
    end

    it 'sets model year on Vehicle' do
      _(@vehicle.model_year).must_equal 2017
    end

    it 'sets division and division_id on Vehicle' do
      _(@vehicle.division).must_equal 'Acura'
      _(@vehicle.division_id).must_equal 1
    end

    it 'sets model and model_id on Vehicle' do
      _(@vehicle.model).must_equal 'MDX'
      _(@vehicle.model_id).must_equal 29763
    end

    describe 'styles' do
      it 'sets id' do
        _(@vehicle.styles.first.id).must_equal 387520
      end

      it 'sets name' do
        _(@vehicle.styles.first.name).must_equal 'FWD w/Advance Pkg'
      end

      it 'sets trim' do
        _(@vehicle.styles.first.trim).must_equal 'w/Advance Pkg'
      end

      it 'sets name_without_trim' do
        _(@vehicle.styles.first.name_without_trim).must_equal 'FWD'
      end

      describe 'body_types' do
        it 'sets name' do
          _(@vehicle.styles.first.body_types.first.name).must_equal 'Sport Utility'
        end

        it 'sets id' do
          _(@vehicle.styles.first.body_types.first.id).must_equal 13
        end
      end
    end

    describe 'engines' do
      it 'sets type' do
        _(@vehicle.engines.first.type).must_equal 'V6 Cylinder Engine'
      end
    end
  end
end
