require 'spec_helper'

describe Harvest::BasicAuthCredentials do
  context '#set_authentication' do
    it 'should set the headers Authorization' do
      credentials = Harvest::BasicAuthCredentials.new(access_token: 'mytoken', account_id: '1')
      credentials.set_authentication(options = {})

      expect(options[:headers]['Authorization']).to eql('Bearer mytoken')
    end
  end
end
