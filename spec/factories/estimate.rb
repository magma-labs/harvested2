FactoryBot.define do
  factory :estimate, class: Harvest::Estimate do
    sequence(:id)
    client_key '13dc088aa7d51ec687f186b146730c3c75dc7423'
    number '1001'
    purchase_order '5678'
    amount 9630.0
    tax 5.0
    tax_amount 450.0
    tax2 2.0
    tax2_amount 180.0
    discount 10.0
    discount_amount 1000.0
    subject 'Online Store - Phase 2'
    notes 'Some notes about the estimate'
    state 'sent'
    currency 'USD'
  end
end


