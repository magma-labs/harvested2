require 'spec_helper'

describe Harvest::Expense do
  it_behaves_like 'a json sanitizer', %w(cache_version)

  describe "#spent_date" do
    it "should parse strings" do
      date = RUBY_VERSION =~ /1.8/ ? "12/01/2009" : "01/12/2009"
      expense = Harvest::Expense.new(:spent_date => date)
      expense.spent_date.should == Date.parse(date)
    end

    it "should accept times" do
      expense = Harvest::Expense.new(:spent_date => Time.utc(2009, 12, 1))
      expense.spent_date.should == Date.new(2009, 12, 1)
    end
  end
end
