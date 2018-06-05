require 'spec_helper'

describe Harvest::UserProjectAssignment do
  describe "#user_as_json" do
    it 'should generate the xml for existing users' do
      assignment = Harvest::UserProjectAssignment.new('user' => { 'id' => 3 })
      expect(assignment.user_as_json).to eql({ 'user' => { 'id' => 3 }})
    end
  end
end
