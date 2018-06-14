module Harvest
  module API
    class Estimates < Base
      include Harvest::Behavior::Crud

      api_model Harvest::Contact
    end
  end
end
