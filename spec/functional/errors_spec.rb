require 'spec_helper'

describe 'harvest errors' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  before { WebMock.disable_net_connect! }

  context 'wraps errors' do
    it 'sould returns a Harvest::BadRequest error' do
      stub_request(:get, /\/clients/).to_return({ status: ['400', 'Bad Request']},
        { body: '[]', status: 200})
      expect { harvest.clients.all }.to raise_error(Harvest::BadRequest)
    end

    it 'sould returns a Harvest::NotFound error' do
      stub_request(:get, /\/clients/)
        .to_return({ status: ['404', 'Not Found'] }, { body: '[]', status: 200})
      expect { harvest.clients.all }.to raise_error(Harvest::NotFound)
    end

    it 'sould returns a Harvest::ServerError error' do
      stub_request(:get, /\/clients/)
        .to_return({ status: ['500', 'Server Error'] },
          { body: '[]', status: 200 })
      expect { harvest.clients.all }.to raise_error(Harvest::ServerError)
    end

    it 'sould returns a Harvest::Unavailable error' do
      stub_request(:get, /\/clients/)
        .to_return({ status: ['502', 'Bad Gateway'] },
          { body: '[]', status: 200 })
      expect { harvest.clients.all }.to raise_error(Harvest::Unavailable)
    end

    it 'sould returns a Harvest::RateLimited error' do
      stub_request(:get, /\/clients/)
        .to_return({ status: ['503', 'Rate Limited'] },
          { body: '[]', status: 200 })
      expect { harvest.clients.all }.to raise_error(Harvest::RateLimited)
    end
  end
end
