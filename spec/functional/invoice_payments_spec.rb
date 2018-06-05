require 'spec_helper'

describe 'harvest invoice payments' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'invoice payments' do
    let(:invoice) { create(:invoice) }
    let(:invoice_payment) { create(:invoice_payment, amount: invoice.amount) }
    let(:invoice_payment_attributes) do
      FactoryBot.attributes_for(:invoice_payment)
    end

    context 'allows to add invoice_payments' do
      before do
        allow(harvest.invoice_payments).to receive(:create)
          .and_return(invoice_payment)
      end

      it 'returns true' do
        expect(invoice_payment.amount).to eql(invoice.amount)
      end
    end

    context 'allows to update invoice_payments' do
      before do
        allow(harvest.invoice_payments).to receive(:update)
          .and_return(invoice_payment)
        invoice_payment.amount = 200
        invoice_payment = harvest.invoice_payments.update(invoice_payment)
      end

      it 'returns true' do
        expect(invoice_payment.amount).to eql(200)
      end
    end

    context 'allows to remove invoice_payments' do
      before do
        allow(harvest.invoice_payments).to receive(:delete).and_return([])
        allow(harvest.invoice_payments).to receive(:all).and_return([])
        harvest.invoice_payments.delete(invoice_payment)
      end

      it 'returns true' do
        expect(harvest.invoice_payments.all.select do |i|
          i.amount == 200
        end).to eql([])
      end
    end
  end
end
