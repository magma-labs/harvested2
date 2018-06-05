require 'harvested2'
require 'webmock/rspec'
require 'byebug'
require 'pry'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each do |file|
  require file
end

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include HarvestedHelpers

  config.before(:suite) do
    WebMock.allow_net_connect!
  end

  config.before(:each) do
    WebMock.allow_net_connect!
  end
end
