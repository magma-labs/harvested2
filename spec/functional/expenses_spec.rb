require 'spec_helper'

describe 'harvest expenses' do
  let(:harvest) { Harvest.client(access_token: 'mytoken', account_id: '123') }

  describe 'categories' do
    let(:expense_category) { create(:expense_category) }
    let(:expense_category_attributes) do
      FactoryBot.attributes_for(:expense_category)
    end

    context 'allows to add clients' do
      before do
        allow(harvest.expense_categories).to receive(:create)
          .and_return(expense_category)
      end

      it 'returns true' do
        expect(expense_category.name).to eql('Mileage')
      end
    end

    context 'allows to update clients' do
      before do
        allow(harvest.expense_categories).to receive(:update)
          .and_return(expense_category)
        expense_category.name = 'Travel'
        expense_category = harvest.expense_categories.update(expense_category)
      end

      it 'returns true' do
        expect(expense_category.name).to eql('Travel')
      end
    end

    context 'allows to delete clients' do
      before do
        allow(harvest.expense_categories).to receive(:delete).and_return([])
        allow(harvest.expense_categories).to receive(:all).and_return([])
        harvest.expense_categories.delete(expense_category)
      end

      it 'returns true' do
        expect(harvest.expense_categories.all.select do |e|
          e.name == 'Travel'
        end).to eql([])
      end
    end
  end

  describe 'expenses' do
    let(:client) { create(:client) }
    let(:project) { create(:project, client: client) }
    let(:expense_category) { create(:expense_category) }
    let(:expense) do
      create(:expense, project: project, expense_category: expense_category)
    end

    context 'allows to add expense' do
      before do
        allow(harvest.expenses).to receive(:create)
          .and_return(expense)
      end

      it 'returns true' do
        expect(expense.notes).to eql('Drive to Chicago')
      end
    end

    context 'allows to update expense' do
      before do
        allow(harvest.expenses).to receive(:update)
          .and_return(expense)
        expense.notes = 'Off to Chicago'
        expense = harvest.expenses.update(expense)
      end

      it 'returns true' do
        expect(expense.notes).to eql('Off to Chicago')
      end
    end

    context 'allows to delete clients' do
      before do
        allow(harvest.expenses).to receive(:delete).and_return([])
        allow(harvest.expenses).to receive(:all).and_return([])
        harvest.expenses.delete(expense)
      end

      it 'returns true' do
        expect(harvest.expenses.all(Time.utc(2009, 12, 28)).select do |e|
          e.notes == 'Off to Chicago'
        end).to eql([])
      end
    end
  end
end
