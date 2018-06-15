module Harvest
  module API
    class ProjectAssignments < Base
      api_model Harvest::ProjectAssignment

      def all(user, query = {})
        api_path = "/users/#{user.id}/project_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            project_project_assignments = api_model.to_json(response.parsed_response)
            response_parsed['project_assignments']
              .concat(project_project_assignments['project_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end

      def me(query = {})
        api_path = "/users/me/project_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            project_assignments = api_model.to_json(response.parsed_response)
            response_parsed['project_assignments']
              .concat(project_assignments['project_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end
    end
  end
end
