module WsdlCassette
  def use_wsdl_cassette
    VCR.use_cassette('wsdl') do
      # Request WSDL to ensure it's recorded to the wsdl cassette
      ChromeData::BaseRequest.wsdl_body

      yield
    end
  end
end
