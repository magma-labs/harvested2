require 'spec_helper'

describe 'harvest tasks' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'tasks' do
    let(:task) { create(:task) }

    context 'allows to add invoice tasks' do
      before do
        allow(harvest.tasks).to receive(:create)
          .and_return(task)
      end

      it 'returns true' do
        expect(task.default_hourly_rate).to eql(120)
        expect(task.name).to eql('A crud task')
      end
    end

    context 'allows to update invoice tasks' do
      before do
        allow(harvest.tasks).to receive(:update)
          .and_return(task)
        task.default_hourly_rate = 140
        task = harvest.tasks.update(task)
      end

      it 'returns true' do
        expect(task.default_hourly_rate).to eql(140)
      end
    end

    context 'allows to remove invoice tasks' do
      before do
        allow(harvest.tasks).to receive(:delete).and_return([])
        allow(harvest.tasks).to receive(:all).and_return([])
        harvest.tasks.delete(task)
      end

      it 'returns true' do
        expect(harvest.tasks.all.select do |t|
          t.name == 'A crud task'
        end).to eql([])
      end
    end
  end

  describe 'task assignments' do
    let(:project) { create(:project) }
    let(:task) do
      create(:task, name: 'A task for joe', default_hourly_rate: 120)
    end
    let(:task_assignment) do
      create(:task_assignment, project: project, task: task)
    end

    context 'allows to add invoice task assignments' do
      before do
        allow(harvest.task_assignments).to receive(:create)
          .and_return(task)
      end

      it 'returns true' do
        expect(task_assignment.hourly_rate).to eql(120)
      end
    end

    context 'allows to update invoice task assignments' do
      before do
        allow(harvest.task_assignments).to receive(:update)
          .and_return(task)
        task_assignment.hourly_rate = 100
        task = harvest.task_assignments.update(task_assignment)
      end

      it 'returns true' do
        expect(task_assignment.hourly_rate).to eql(100)
      end
    end

    context 'allows to remove invoice task assignments' do
      before do
        allow(harvest.task_assignments).to receive(:delete)
          .and_return([])
        allow(harvest.task_assignments).to receive(:all)
          .and_return([task_assignment])
        harvest.task_assignments.delete(task_assignment)
      end

      it 'returns true' do
        expect(harvest.task_assignments.all(project).count).to eql(1)
      end
    end
  end

  describe 'projects' do
    let(:project) { create(:project) }
    let(:task) do
      create(:task, name: 'A task for joe', default_hourly_rate: 120)
    end
    let(:task_assignment) do
      create(:task_assignment, project: project, task: task)
    end

    context 'allows to add project and task' do
      before do
        allow(harvest.projects).to receive(:create_task)
          .and_return(task)
          allow(harvest.task_assignments).to receive(:all)
          .and_return([task_assignment])
      end

      it 'returns true' do
        expect(harvest.task_assignments.all(project).size).to eql(1)
      end
    end
  end
end
