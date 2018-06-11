module Harvest
  module API
    class TaskAssignments < Base
      api_model Harvest::TaskAssignment

      def all(project, query = {})
        api_path = "/projects/#{project.id}/task_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            project_task_assignments = api_model.to_json(response.parsed_response)
            response_parsed['task_assignments']
              .concat(project_task_assignments['task_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end

      def find(project, task_assignment)
        api_path = "/projects/#{project.id}/task_assignments/#{task_assignment.id}"
        response = request(:get, credentials, api_path)
        api_model.parse(response.parsed_response)
      end

      def create(project, task_assignment)
        task_assignment = api_model.wrap(task_assignment)
        api_path = "/projects/#{project.id}/task_assignments"
        response = request(:post, credentials, api_path, body: task_assignment.to_json)
        find(task_assignment.project_id, task_assignment.id)
      end

      def update(project, task_assignment)
        task_assignment = api_model.wrap(task_assignment)
        api_path = "/projects/#{project.id}/task_assignments/#{task_assignment.id}"
        request(:put, credentials, api_path, body: task_assignment.to_json)
        find(task_assignment.project_id, task_assignment.id)
      end

      def delete(task_assignment)
        api_path = "/projects/#{project.id}/task_assignments/#{task_assignment.id}"
        response = request(:delete, credentials, api_path)
        task_assignment.id
      end

      def me(query = {})
        api_path = "/task_assignments"
        response = request(:get, credentials, api_path, query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }
            response_page = request(:get, credentials, api_path, query: query)
            task_assignments = api_model.to_json(response.parsed_response)
            response_parsed['task_assignments']
              .concat(task_assignments['task_assignments'])
          end
        end

        api_model.parse(response_parsed)
      end
    end
  end
end
