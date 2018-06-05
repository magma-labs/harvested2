FactoryBot.define do
  factory :expense_category, class: Harvest::ExpenseCategory do
    name 'Mileage'
    unit_price 100
    unit_name 'mile'
  end
end
