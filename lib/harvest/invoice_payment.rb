module Harvest
  class InvoicePayment < Hashie::Mash
    include Harvest::Model

    skip_json_root true

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.payment_gateway = args.delete('payment_gateway') if args['payment_gateway']
      super
    end

    def payment_gateway=(payment_gateway)
      self['payment_gateway_id'] = payment_gateway['id']
    end
  end
end
