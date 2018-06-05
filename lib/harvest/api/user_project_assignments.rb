module Harvest
  module API
    class UserProjectAssignments < Base
      # Returns the project assignments list for specific user
      def all(user, query = {})
        response = request(:get,
          credentials,
          "/users/#{user.to_i}/project_assignments", { query: query })
        Harvest::UserProjectAssignment.parse(response.parsed_response)
      end

      # Returns the project assignments for current user
      def me(user)
        response = request(:get,
          credentials,
          '/users/me/project_assignments')
        Harvest::UserProjectAssignment.parse(response.parsed_response)
      end
    end
  end
end
