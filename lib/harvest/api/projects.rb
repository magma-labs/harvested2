module Harvest
  module API
    class Projects < Base
      api_model Harvest::Project

      include Harvest::Behavior::Crud
    end
  end
end
