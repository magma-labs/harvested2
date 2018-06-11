module Harvest
  module API
    class InvoiceCategories < Base
      include Harvest::Behavior::Crud

      api_model Harvest::InvoiceCategory
    end
  end
end
