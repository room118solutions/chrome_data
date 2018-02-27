module ChromeData
  class CollectionRequest < BaseRequest
    attr_accessor :id, :name

    class << self
      def request_name
        # Cheap-o inflector
        "get#{name.split('::').last}s"
      end

      def request(data)
        super do |response|
          # Find elements matching class name and instantiate them using their id attribute and text
          find_elements(name.split('::').last.downcase, response).map do |e|
            new id: e.attr('id').to_i, name: e.text
          end
        end
      end
    end
  end
end