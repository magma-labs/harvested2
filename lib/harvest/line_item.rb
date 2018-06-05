module Harvest
  class LineItem < Hashie::Mash
    def initialize(args = {}, _ = nil)
      args = args.stringify_keys
      self.project = args.delete('project')
      super
    end

    def project=(project)
      return nil if project.nil?

      self['project_id'] = project['id'].to_i
    end

    def active?
      !deactivated
    end

    def line_item_as_json
      { 'line_item' => { 'id' => line_item_id } }
    end
  end
end
