require 'spec_helper'

describe 'harvest users' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'users' do
    let(:user) { create(:user) }

    context 'allows to add users' do
      before do
        allow(harvest.users).to receive(:create).and_return(user)
      end

      it 'returns true' do
        expect(user.id).not_to be_nil
        expect(user.first_name).to eql('Edgar')
        expect(user.last_name).to eql('Ruth')
      end
    end

    context 'allows to update users' do
      before do
        allow(harvest.users).to receive(:update).and_return(user)
        user.first_name = 'Joey'
        user = harvest.users.update(user)
      end

      it 'returns true' do
        expect(user.first_name).to eql('Joey')
      end
    end

    context 'allows to remove users' do
      before do
        allow(harvest.users).to receive(:delete).and_return([])
        allow(harvest.users).to receive(:all).and_return([])
        harvest.users.delete(user)
      end

      it 'returns true' do
        expect(harvest.users.all.select do |u|
          u.first_name == 'Joey'
        end).to eql([])
      end
    end

    context 'allows activating and deactivating users' do
      let(:user) { create(:user, :active) }

      before do
        allow(harvest.users).to receive(:update)
          .and_return(user)
      end

      it 'should be active' do
        expect(user).to be_active
      end

      it 'should be deactive' do
        user.is_active = false
        user = harvest.users.update(user)
        expect(user).not_to be_active
      end

      it 'should reactive a user' do
        user.is_active = true
        user = harvest.users.update(user)
        expect(user).to be_active
      end
    end
  end

  describe 'assignments' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }
    let(:user_project_assignment) do
      create(:user_assignment, project: project, user: user)
    end
    let(:user_assignment_attributes) { FactoryBot.attributes_for(:user) }

    # context 'allows to add user assignments' do
    #   before do
    #     allow(harvest.user_project_assignments).to receive(:create)
    #       .and_return(user_assignment)
    #     user_assignment = harvest.user_project_assignments
    #       .create(user_assignment_attributes)
    #   end

    #   it 'should be true' do
    #     expect(user_assignment.hourly_rate).to eql(120)
    #   end
    # end

    # context 'allows to update user assignments' do
    #   before do
    #     allow(harvest.user_project_assignments).to receive(:update)
    #       .and_return(user)
    #     user.hourly_rate = 100
    #     user = harvest.user_project_assignments.update(user)
    #   end

    #   it 'returns true' do
    #     expect(user.hourly_rate).to eql(100)
    #   end
    # end

    # context 'allows to delete user assignments' do
    #   before do
    #     allow(harvest.user_project_assignments).to receive(:delete)
    #       .and_return([])
    #     allow(harvest.user_project_assignments).to receive(:all).and_return([])
    #     harvest.user_project_assignments.delete(user_assignment)
    #   end

    #   it 'should return empty' do
    #     expect(harvest.user_project_assignments.all.select do |a|
    #       a.hourly_rate == 100
    #     end).to eql([])
    #   end
    # end
  end
end
