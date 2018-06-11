module Harvest
  # The model that contains information about a client
  #
  # == Fields
  # [+user+] user attributes
  # [+accounts+] accounts attributes
  class Account < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/accounts'
  end
end
