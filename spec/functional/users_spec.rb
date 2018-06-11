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
end
