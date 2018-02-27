module ChromeData
  class Vehicle < BaseRequest
    class Engine < Struct.new(:type); end

    attr_accessor :model_year, :division, :model, :styles, :engines

    class << self
      def request_name
        "describeVehicle"
      end

      def find_by_vin(vin)
        request 'vin' => vin do |response|
          if vin_description = find_elements('vinDescription', response).first
            new.tap do |v|
              v.model_year = vin_description.attr('modelYear').to_i
              v.division   = vin_description.attr('division')
              v.model      = vin_description.attr('modelName')
              v.styles     = find_elements('style', response).map { |e| parse_style(e) }
              v.engines    = parse_engines(response)
            end
          end
        end
      end

      def find_by_style_id(style_id)
        request 'styleId' => style_id do |response|
          status = find_elements('responseStatus', response).first

          if status.attr('responseCode') == 'Successful'
            # We assume that only one style is returned here,
            # since we requested a specific style ID,
            # but the API docs aren't clear on that
            style = find_elements('style', response).first

            new.tap do |v|
              v.model_year = style.attr('modelYear').to_i
              v.division   = style.xpath("x:division", 'x' => response.body.namespace.href).first.text
              v.model      = style.xpath("x:model", 'x' => response.body.namespace.href).first.text
              v.styles     = [parse_style(style)]
              v.engines    = parse_engines(response)
            end
          end
        end
      end

      def parse_style(element)
        Style.new(
          id: element.attr('id').to_i,
          name: element.attr('name'),
          trim: element.attr('trim'),
          name_without_trim: element.attr('nameWoTrim'),
          body_types: element.xpath("x:bodyType", 'x' => element.namespace.href).map do |bt|
            Style::BodyType.new(bt.attr('id').to_i, bt.text)
          end
        )
      end

      def parse_engines(response)
        find_elements('engine', response).map do |e|
          Engine.new(e.at_xpath("x:engineType", 'x' => response.body.namespace.href).text)
        end
      end
    end
  end
end