module Harvest
  class InvoicePayment < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/payments'
  end
end
