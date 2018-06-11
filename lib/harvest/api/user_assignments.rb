module Harvest
  module API
    class UserAssignments < Base
      api_model Harvest::UserAssignment

      def all(project, query = {})
        api_path = "/projects/#{project.id}/user_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            project_user_assignments = api_model.to_json(response.parsed_response)
            response_parsed['user_assignments']
              .concat(project_user_assignments['user_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end

      def find(project, user_assignment)
        api_path = "/projects/#{project.id}/user_assignments/#{user_assignment.id}"
        response = request(:get, credentials, api_path)
        api_model.parse(response.parsed_response)
      end

      def create(project, user_assignment)
        user_assignment = api_model.wrap(user_assignment)
        api_path = "/projects/#{project.id}/user_assignments"
        response = request(:post, credentials, api_path, body: user_assignment.to_json)
        find(user_assignment.project_id, user_assignment.id)
      end

      def update(project, user_assignment)
        user_assignment = api_model.wrap(user_assignment)
        api_path = "/projects/#{project.id}/user_assignments/#{user_assignment.id}"
        request(:put, credentials, api_path, body: user_assignment.to_json)
        find(user_assignment.project_id, user_assignment.id)
      end

      def delete(user_assignment)
        api_path = "/projects/#{project.id}/user_assignments/#{user_assignment.id}"
        response = request(:delete, credentials, api_path)
        user_assignment.id
      end

      def me(query = {})
        api_path = "/user_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            user_assignments = api_model.to_json(response.parsed_response)
            response_parsed['user_assignments']
              .concat(user_assignments['user_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end
    end
  end
end
