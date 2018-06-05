require 'spec_helper'

describe Harvest::TaskAssignment do
  context 'task_as_json' do
    it 'generates the json for existing tasks' do
      assignment = Harvest::TaskAssignment.new('task' => { 'id' => 3 })
      expect(assignment.task_as_json).to eql({ 'task' => { 'id' => 3 }})
    end
  end
end
