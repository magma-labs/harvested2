module Harvest
  module API
    class Users < Base
      api_model Harvest::User

      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable

      def all(user = nil, query_options = {})
        query = query_options.merge!(of_user_query(user))
        response = request(:get, credentials, api_model.api_path, query: query)
        response_parsed = to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_model.api_path, query: query)
            response_parsed['users'].concat(to_json(response.parsed_response)['users'])
          end
        end

        api_model.parse(response_parsed)
      end

      # Triggers Harvest to reset the user's password and sends them an email to change it.
      # @overload reset_password(id)
      #   @param [Integer] id the id of the user you want to reset the password for
      # @overload reset_password(user)
      #   @param [Harvest::User] user the user you want to reset the password for
      # @return [Harvest::User] the user you passed in
      def reset_password(user)
        request(:post, credentials, "#{api_model.api_path}/#{user.to_i}/reset_password")
        user
      end
    end
  end
end
