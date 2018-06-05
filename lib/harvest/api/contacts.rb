module Harvest
  module API
    class Contacts < Base
      include Harvest::Behavior::Crud

      api_model Harvest::Contact
    end
  end
end
