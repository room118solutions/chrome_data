require "net/http"
require "lolsoap"

module ChromeData
  class BaseRequest
    API_REVISION = '7c'

    def initialize(attrs={})
      attrs.each do |k, v|
        send "#{k}=", v
      end
    end

    class << self
      # Builds request, sets additional data on request element, makes request,
      # and yields response to given block, which is expected to return an appropriate response
      def request(data, &block)
        request = build_request

        request.body do |b|
          # Set configured account info on builder
          b.accountInfo(
            number: ChromeData.config.account_number,
            secret: ChromeData.config.account_secret,
            country: ChromeData.config.country,
            language: ChromeData.config.language
          )

          # Set additional elements on builder
          data.each do |k, v|
            # Add the key/value pair as an attribute to the request element if that's what it should be,
            # otherwise add it as a sub-element
            # NOTE: This basically mirrors LolSoap::Builder#method_missing
            #       because Builder undefines most methods, including #send
            if b.__type__.has_attribute?(k)
              b.__attribute__ k, v
            else
              b.__tag__ k, v
            end
          end
        end

        # Make the request and pass to block
        block.call make_request(request)
      end

      # Makes request, returns LolSoap::Response
      def make_request(request)
        raw_response = Net::HTTP.start(endpoint_uri.host, endpoint_uri.port) do |http|
          http.request_post(endpoint_uri.path, request.content, request.headers)
        end

        client.response(request, raw_response.body)
      end

      # Builds request, returns LolSoap::Request
      def build_request
        client.request request_name
      end

      def client
        @@client ||= LolSoap::Client.new(wsdl_body)
      end

      def wsdl_body
        @@wsdl_body ||= Net::HTTP.get_response(URI("http://services.chromedata.com/Description/#{API_REVISION}?wsdl")).body
      end

      def endpoint_uri
        @@endpoint_uri ||= URI(client.wsdl.endpoint)
      end

      # Given an element_name and LolSoap::Response, returns an array of Nokogiri::XML::Elements
      def find_elements(element_name, response)
        response.body.xpath(".//x:#{element_name}", 'x' => response.body.namespace.href)
      end

      def request_name
        raise NotImplementedError, '.request_name should be implemented in subclass'
      end
    end
  end
end
