module Harvest
  class UserAssignment < Hashie::Mash
    include Harvest::Model

    skip_json_root true

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.user = args.delete('user') if args['user']
      self.project = args.delete('project') if args['project']

      super
    end

    def user=(user)
      self['user_id'] = user['id']
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def active?
      !deactivated
    end
  end
end
