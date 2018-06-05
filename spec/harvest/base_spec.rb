require 'spec_helper'

describe Harvest::Base do
  describe 'username/password errors' do
    it 'should raise error if missing credentials' do
      lambda { Harvest::Base.new }
        .should raise_error(/must provide either/i)
    end
  end
end
