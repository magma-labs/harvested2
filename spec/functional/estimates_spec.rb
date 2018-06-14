require 'spec_helper'

describe 'harvest estimates' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'estimates' do
    let(:estimate) { create(:estimate) }

    context 'allows to add invoice categories' do
      before do
        allow(harvest.estimates).to receive(:create)
          .and_return(estimate)
      end

      it 'returns true' do
        expect(estimate.number).to eql('1001')
      end
    end

    context 'allows to update invoice categories' do
      before do
        allow(harvest.estimates).to receive(:update)
          .and_return(estimate)
        estimate.discount = 20.0
        estimate = harvest.estimates.update(estimate)
      end

      it 'returns true' do
        expect(estimate.discount).to eql(20.0)
      end
    end

    context 'allows to remove estimates' do
      before do
        allow(harvest.estimates).to receive(:delete).and_return([])
        allow(harvest.estimates).to receive(:all).and_return([])
        harvest.estimates.delete(estimate)
      end

      it 'returns true' do
        expect(harvest.estimates.all.select do |p|
          p.number == '1001'
        end).to eql([])
      end
    end
  end
end
