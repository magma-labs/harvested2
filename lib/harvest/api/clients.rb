module Harvest
  module API
    class Clients < Base
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable

      api_model Harvest::Client
    end
  end
end
