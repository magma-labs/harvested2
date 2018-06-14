module Harvest
  class TaskAssignment < Hashie::Mash
    include Harvest::Model

    skip_json_root true

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.task = args.delete('task') if args['task']
      self.project = args.delete('project') if args['project']
      super
    end

    def task=(task)
      self['task_id'] = task['id']
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def active?
      !deactivated
    end
  end
end
