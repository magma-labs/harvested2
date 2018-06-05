module Harvest
  class BasicAuthCredentials
    def initialize(access_token: nil, account_id: nil)
      @access_token = access_token
      @account_id = account_id
    end

    def set_authentication(request_options)
      request_options[:headers] ||= {}
      request_options[:headers]['Authorization'] = "Bearer #{@access_token}"
      request_options[:headers]['Harvest-Account-ID'] = @account_id
    end

    def host
      'https://api.harvestapp.com/v2'
    end
  end

  class OAuthCredentials
    def initialize(access_token: nil, client_id: nil)
      @access_token = access_token
      @client_id = client_id
    end

    def set_authentication(request_options)
      request_options[:query] ||= {}
      request_options[:query]["access_token"] = @access_token
    end

    def host
      'https://api.harvestapp.com/v2'
    end
  end
end
