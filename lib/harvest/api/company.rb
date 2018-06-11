module Harvest
  module API
    class Company < Base
      api_model Harvest::Company

      def info
        response = request(:get, credentials, api_model.api_path)
        api_model.parse(response.parsed_response)
      end
    end
  end
end
