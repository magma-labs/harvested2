FactoryBot.define do
  factory :invoice_payment, class: Harvest::InvoicePayment do
    paid_at Time.now
    amount 0.00
    notes 'Payment received'
  end
end
