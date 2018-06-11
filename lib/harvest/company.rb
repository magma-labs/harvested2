module Harvest
  class Company < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/company'
  end
end
