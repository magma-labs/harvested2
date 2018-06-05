require 'spec_helper'

describe 'harvest time tracking' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'time entries' do
    let(:time_entry) { create(:time_entry) }

    context 'allows to add time entry' do
      before do
        allow(harvest.time).to receive(:create)
          .and_return(time_entry)
      end

      it 'returns true' do
        expect(time_entry.notes).to eql('Test api support')
      end
    end

    context 'allows to update time entry' do
      before do
        allow(harvest.time).to receive(:update)
          .and_return(time_entry)
        time_entry.notes = 'New test api support'
        time_entry = harvest.time.update(time_entry)
      end

      it 'returns true' do
        expect(time_entry.notes).to eql('New test api support')
      end
    end

    context 'allows to remove time entry' do
      before do
        allow(harvest.time).to receive(:delete).and_return([])
        allow(harvest.time).to receive(:all).and_return([])
        harvest.time.delete(time_entry)
      end

      it 'returns true' do
        expect(harvest.time.all.select do |t|
          t.notes == 'New test api support'
        end).to eql([])
      end
    end
  end

  describe 'toggle' do
    let(:time_entry) { create(:time_entry, :started) }

    before do
      allow(harvest.time).to receive(:toggle)
        .and_return(time_entry)
    end

    it 'should be active' do
      expect(time_entry.timer_started_at).not_to be_nil
    end

    it 'should be deactive' do
      time_entry.timer_started_at = nil
      time_entry = harvest.time.toggle(time_entry)
      expect(time_entry.timer_started_at).to be_nil
    end

    it 'should reactive a time_entry' do
      time_entry = harvest.time.toggle(time_entry)
      expect(time_entry).not_to be_nil
    end
  end

  describe 'projects' do
    let(:user) { create(:user) }
    let(:time_entry) { create(:time_entry) }

    context 'allows to add project and task' do
      before do
        allow(harvest.time).to receive(:trackable_projects)
          .and_return([])
      end

      it 'returns true' do
        expect(harvest.time.trackable_projects(Time.now, user)).to eql([])
      end
    end
  end
end
