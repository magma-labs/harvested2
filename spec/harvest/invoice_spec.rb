require 'spec_helper'

describe Harvest::Invoice do
  context 'line_items' do
    it 'parses csv into objects' do
      invoice = described_class.new(line_items: "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,100\nService,def,1.00,20.00,20.0,false,false,101\n")
      expect(invoice.line_items.count).to be(2)

      line_item = invoice.line_items.first
      expect(line_item.kind).to eql('Service')
      expect(line_item.project_id).to eql('100')
    end

    it 'parses csv into objects w/o projects' do
      invoice = described_class.new(line_items: "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,\nService,def,1.00,20.00,20.0,false,false,\n")
      expect(invoice.line_items.count).to be(2)

      line_item = invoice.line_items.first
      expect(line_item.kind).to eql('Service')
      expect(line_item.description).to eql('Abc')
    end

    it 'parses empty strings' do
      invoice = described_class.new(line_items: '')

      expect(invoice.line_items).to eql([])
    end

    it 'accepts rich objects' do
      invoice_line_item = Harvest::LineItem.new(kind: 'Service')
      invoice = Harvest::Invoice.new(line_items: [invoice_line_item])
      expect(invoice.line_items.count).to be(1)
    end

    it 'accepts nil' do
      invoice = described_class.new(line_items: nil)
      expect(invoice.line_items).to eql([])
    end
  end

  context 'as_json' do
    it 'only updates line items remotely if it the invoice is told to' do
      invoice = described_class.new(line_items: "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,\nService,def,1.00,20.00,20.0,false,false,\n")
      expect(invoice.line_items.count).to eql(2)
      expect(invoice.line_items.first.kind).to eql('Service')
    end
  end
end
