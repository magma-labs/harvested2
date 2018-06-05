require 'spec_helper'

describe 'harvest invoices' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'categories' do
    let(:invoice_category) { create(:invoice_category) }

    context 'allows to add invoice categories' do
      before do
        allow(harvest.invoice_categories).to receive(:create)
          .and_return(invoice_category)
      end

      it 'returns true' do
        expect(invoice_category.name).to eql('New Category')
      end
    end

    context 'allows to update invoice categories' do
      before do
        allow(harvest.invoice_categories).to receive(:update)
          .and_return(invoice_category)
        invoice_category.name = 'Updated Category'
        invoice_category = harvest.invoice_categories.update(invoice_category)
      end

      it 'returns true' do
        expect(invoice_category.name).to eql('Updated Category')
      end
    end

    context 'allows to remove invoice categories' do
      before do
        allow(harvest.invoice_categories).to receive(:delete).and_return([])
        allow(harvest.invoice_categories).to receive(:all).and_return([])
        harvest.invoice_categories.delete(invoice_category)
      end

      it 'returns true' do
        expect(harvest.invoice_categories.all.select do |p|
          p.name == 'Updated Category'
        end).to eql([])
      end
    end
  end

  describe 'invoices' do
    let(:invoice_category) { create(:invoice_category) }
    let(:invoice) { create(:invoice) }
    let(:line_item) { create(:line_item) }

    context 'allows to add invoice invoices' do
      before do
        allow(harvest.invoices).to receive(:create)
          .and_return(invoice)
      end

      it 'returns true' do
        expect(invoice.subject)
          .to eql("Invoice for Joe's Stream Cleaning")
        expect(invoice.amount).to eql(2400.0)
        expect(invoice.line_items.size).to eql(1)
      end
    end

    context 'allows to update invoices' do
      before do
        allow(harvest.invoices).to receive(:update)
          .and_return(invoice)
        invoice.subject = 'Updated Invoice for Joe'
        invoice.line_items << line_item
        invoice.update_line_items = true
        invoice.amount = 4800.0
        invoice = harvest.invoices.update(invoice)
      end

      it 'returns true' do
        expect(invoice.subject).to eql('Updated Invoice for Joe')
        expect(invoice.amount).to eql(4800.0)
        expect(invoice.line_items.size).to eql(2)
      end
    end

    context 'allows to remove invoices' do
      before do
        allow(harvest.invoices).to receive(:delete).and_return([])
        allow(harvest.invoices).to receive(:all).and_return([])
        harvest.invoices.delete(invoice)
      end

      it 'returns true' do
        expect(harvest.invoices.all.select do |i|
          i.number == '1000'
        end).to eql([])
      end
    end
  end

  describe 'read' do
    let(:invoice_category) { create(:invoice_category) }
    let(:invoice) { create(:invoice) }
    let(:invoice_attributes) { FactoryBot.attributes_for(:invoice) }
    let(:invoices) { [invoice] }

    context 'allows finding one invoice with parameters' do
       before do
        allow(harvest.invoices).to receive(:create)
          .and_return(invoice)
        allow(harvest.invoices).to receive(:find)
          .and_return(invoice)
        allow(harvest.invoices).to receive(:all).and_return(invoices)

        invoice = harvest.invoices.create(invoice_attributes)
        result = harvest.invoices.find(invoice.id)
      end

      it 'returns a specific invoice' do
        expect(invoice.subject).to eql("Invoice for Joe's Stream Cleaning")
        expect(invoice.amount).to eql(2400.0)
        expect(invoice.line_items.size).to eql(1)
        expect(invoice.due_at).to eql('2011-03-31')
        expect(invoices.count).to eql(1)
      end

      it 'returns invoices' do
        invoices = harvest.invoices.all(status: 'draft')
        expect(invoice.subject).to eql("Invoice for Joe's Stream Cleaning")
        expect(invoice.amount).to eql(2400.0)
        expect(invoice.line_items.size).to eql(1)
        expect(invoice.due_at).to eql('2011-03-31')
        expect(invoices.count).to eql(1)
      end
    end
  end
end
