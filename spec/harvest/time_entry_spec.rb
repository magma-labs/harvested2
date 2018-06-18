require 'spec_helper'

describe Harvest::TimeEntry do
  context '#spent_date' do
    it 'should parse strings' do
      date = RUBY_VERSION =~ /1.8/ ? '12/01/2009' : '01/12/2009'
      entry = Harvest::TimeEntry.new(:spent_date => date)
      expect(entry.spent_date).to eql(Date.parse(date))
    end

    it 'should accept times' do
      entry = Harvest::TimeEntry.new(:spent_date => Time.utc(2009, 12, 1))
      expect(entry.spent_date).to eql(Date.new(2009, 12, 1))
    end
  end
end
