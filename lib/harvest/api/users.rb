module Harvest
  module API
    class Users < Base
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable

      api_model Harvest::User
    end
  end
end
