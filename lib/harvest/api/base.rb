module Harvest
  module API
    class Base
      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
      end

      class << self
        def api_model(klass)
          class_eval <<-END
            def api_model
              #{klass}
            end
          END
        end
      end

      protected

      def request(method, credentials, path, options = {})
        params = {
          path: path,
          options: options,
          method: method
        }

        httparty_options = {
          query:  options[:query],
          body:   options[:body],
          format: :plain,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=utf-8',
            'User-Agent': "Harvested/#{Harvest::VERSION}"
          }.update(options[:headers] || {})
        }

        credentials.set_authentication(httparty_options)
        response = HTTParty.send(method, "#{credentials.host}#{path}",
          httparty_options)

        params[:response] = response.inspect.to_s

        case response.code
        when 200..201
          response
        when 400
          raise Harvest::BadRequest.new(response, params)
        when 401
          raise Harvest::AuthenticationFailed.new(response, params)
        when 404
          raise Harvest::NotFound.new(response, params,
            'Do you have sufficient privileges?')
        when 500
          raise Harvest::ServerError.new(response, params)
        when 502
          raise Harvest::Unavailable.new(response, params)
        when 503
          raise Harvest::RateLimited.new(response, params)
        else
          raise Harvest::InformHarvest.new(response, params)
        end
      end

      def of_user_query(user)
        query = user.nil? ? {} : { 'of_user': user.to_i }
      end
    end
  end
end
