require 'spec_helper'

describe 'harvest invoice messages' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'invoice messages' do
    let(:invoice) { create(:invoice) }
    let(:invoice_message) { create(:invoice_message) }

    context 'allows to add invoice_messages' do
      before do
        allow(harvest.invoice_messages).to receive(:create)
          .and_return(invoice_message)
      end

      it 'returns true' do
        expect(invoice_message.body).to eql('The message body goes here')
      end
    end

    context 'allows to update invoice_messages' do
      before do
        allow(harvest.invoice_messages).to receive(:update)
          .and_return(invoice_message)
        invoice_message.body = 'New body text'
        invoice_message = harvest.invoice_messages.update(invoice_message)
      end

      it 'returns true' do
        expect(invoice_message.body).to eql('New body text')
      end
    end

    context 'allows to remove invoice_messages' do
      before do
        allow(harvest.invoice_messages).to receive(:delete).and_return([])
        allow(harvest.invoice_messages).to receive(:all).and_return([])
        harvest.invoice_messages.delete(invoice_message)
      end

      it 'returns true' do
        expect(harvest.invoice_messages.all.select do |i|
          i.body == 'New body text'
        end).to eql([])
      end
    end
  end
end
