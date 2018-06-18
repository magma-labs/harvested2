require 'spec_helper'

describe Harvest::OAuthCredentials do
  context '#set_authentication' do
    it 'should set the access token in the query' do
      credentials = Harvest::OAuthCredentials.new(access_token: 'theaccesstoken')
      credentials.set_authentication(options = {})
      expect(options[:query]['access_token']).to eql('theaccesstoken')
    end
  end
end
