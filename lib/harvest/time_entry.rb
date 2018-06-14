module Harvest
  class TimeEntry < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/time_entries'

    delegate_methods(closed?: :is_closed,
                     billed?: :is_billed)

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.invoice = args.delete('invoice')
      self.user = args.delete('user') if args['user']
      self.task = args.delete('task') if args['task']
      self.client = args.delete('client') if args['client']
      self.project = args.delete('project') if args['project']
      self.spent_date = args.delete('spent_date') if args['spent_date']
      self.user_assignment = args.delete('user_assignment') if args['user_assignment']
      self.task_assignment = args.delete('task_assignment') if args['task_assignment']
      super
    end

    def invoice=(invoice)
      self['invoice_id'] = invoice && invoice['id']
    end

    def user=(user)
      self['user_id'] = user['id']
    end

    def client=(client)
      self['client_id'] = client['id']
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def task=(task)
      self['task_id'] = task['id']
    end

    def spent_date=(date)
      self['spent_date'] = Date.parse(date.to_s)
    end

    def user_assignment=(user_assignment)
      self['user_assignment_id'] = user_assignment['id']
    end

    def task_assignment=(task_assignment)
      self['task_assignment_id'] = task_assignment['id']
    end
  end
end
