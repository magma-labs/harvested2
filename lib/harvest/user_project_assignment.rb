module Harvest
  class UserProjectAssignment < Hashie::Mash
    include Harvest::Model

    skip_json_root true

    def initialize(args = {}, _ = nil)
      args = args.stringify_keys
      self.user = args.delete('user') if args['user']
      self.project = args.delete('project') if args['project']

      super
    end

    def user=(user)
      self['user_id'] = user['id'].to_i
    end

    def project=(project)
      self['project_id'] = project['id'].to_i
    end

    def active?
      !deactivated
    end

    def user_as_json
      { 'user' => { 'id' => user_id } }
    end
  end
end
