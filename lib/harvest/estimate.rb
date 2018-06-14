module Harvest
  class Estimate < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/estimates'

    attr_reader :line_items

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.client = args.delete('client') if args['client']
      self.creator = args.delete('creator') if args['creator']
      self.line_items = args.delete('line_items') if args['line_items']
      self.line_items = [] if self.line_items.nil?
      super
    end

    def client=(client)
      self['client_id'] = client['id']
    end

    def creator=(creator)
      self['creator_id'] = creator['id']
    end

    def line_items=(line_items)
      @line_items = line_items.map do |row|
        Harvest::LineItem.new(row)
      end || []
    end
  end
end
