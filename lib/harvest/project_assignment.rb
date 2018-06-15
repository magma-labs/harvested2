module Harvest
  class ProjectAssignment < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/project_assignments'

    attr_reader :task_assignments

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.client = args.delete('client') if args['client']
      self.project = args.delete('project') if args['project']
      self.task_assignments = args.delete('task_assignments') if args['task_assignments']
      self.task_assignments = [] if self.task_assignments.nil?
      super
    end

    def client=(client)
      self['client_id'] = client['id']
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def task_assignments=(task_assignments)
      @task_assignments = task_assignments.map do |row|
        Harvest::TaskAssignment.new(row)
      end || []
    end

    def active?
      !deactivated
    end
  end
end
