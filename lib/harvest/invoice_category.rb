module Harvest
  class InvoiceCategory < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/invoice_item_categories'
  end
end
