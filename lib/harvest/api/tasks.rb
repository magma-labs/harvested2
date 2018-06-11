module Harvest
  module API
    class Tasks < Base
      include Harvest::Behavior::Crud

      api_model Harvest::Task
    end
  end
end
