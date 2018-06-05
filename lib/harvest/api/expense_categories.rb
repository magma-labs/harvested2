module Harvest
  module API
    class ExpenseCategories < Base
      include Harvest::Behavior::Crud

      api_model Harvest::ExpenseCategory
    end
  end
end
