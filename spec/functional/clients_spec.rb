require 'spec_helper'

describe 'harvest clients' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'clients' do
    let(:client) { create(:client) }
    let(:client_attributes) { FactoryBot.attributes_for(:client) }

    context 'allows to add clients' do
      before do
        allow(harvest.clients).to receive(:create).and_return(client)
      end

      it 'returns true' do
        expect(client.name).to eql(client_attributes[:name])
      end
    end

    context 'allows to update clients' do
      before do
        allow(harvest.clients).to receive(:update).and_return(client)
        client.name = "Joe and Frank's Steam Cleaning"
        client = harvest.clients.update(client)
      end

      it 'returns true' do
        expect(client.name).to eql("Joe and Frank's Steam Cleaning")
      end
    end

    context 'allows to remove clients' do
      before do
        allow(harvest.clients).to receive(:delete).and_return([])
        allow(harvest.clients).to receive(:all).and_return([])
        harvest.clients.delete(client)
      end

      it 'returns true' do
        expect(harvest.clients.all.select do |p|
          p.name == "Joe and Frank's Steam Cleaning"
        end).to eql([])
      end
    end

    context 'allows activating and deactivating clients' do
      let(:active_client) { create(:client, :active) }
      let(:deactive_client) { create(:client, :deactive) }

      before do
        allow(harvest.clients).to receive(:deactivate)
          .and_return(deactive_client)
        allow(harvest.clients).to receive(:activate)
          .and_return(active_client)
      end

      it 'should be active' do
        expect(active_client).to be_active
      end

      it 'should be deactive' do
        client = harvest.clients.deactivate(client)
        expect(deactive_client).not_to be_active
      end

      it 'should reactive a client' do
        client = harvest.clients.activate(client)
        expect(active_client).to be_active
      end
    end
  end

  describe 'contacts' do
    let(:client) { create(:client) }
    let(:contact) { create(:contact, client: client) }
    let(:contact_attributes) { FactoryBot.attributes_for(:contact) }

    context 'allows to add contacts' do
      before do
        allow(harvest.contacts).to receive(:create)
          .and_return(contact)
        contact = harvest.contacts.create(contact_attributes)
      end

      it 'should be true' do
        expect(contact.client_id).to eql(client.id)
        expect(contact.email).to eql('jane@example.com')
      end
    end

    context 'allows to delete contacts' do
      before do
        allow(harvest.contacts).to receive(:delete).and_return([])
        allow(harvest.contacts).to receive(:all).and_return([])
        contact = harvest.contacts.delete(contact)
      end

      it 'should return empty' do
        expect(harvest.contacts.all.select do |e|
          e.email == 'jane@example.com'
        end).to eql([])
      end
    end
  end
end
