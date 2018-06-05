FactoryBot.define do
  factory :line_item, class: Harvest::LineItem do
    kind 'Service'
    description 'Description'
    quantity 200
    unit_price '12.00'
  end
end
