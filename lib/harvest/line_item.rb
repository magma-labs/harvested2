module Harvest
  class LineItem < Hashie::Mash
    def initialize(args = {}, _ = nil)
      args = args.stringify_keys
      self.project = args.delete('project') if args['project']
      super
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def active?
      !deactivated
    end

    def line_item_as_json
      { 'line_item' => { 'id' => line_item_id } }
    end
  end
end
