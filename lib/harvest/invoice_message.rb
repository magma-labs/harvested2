module Harvest
  class InvoiceMessage < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/messages'
  end
end
