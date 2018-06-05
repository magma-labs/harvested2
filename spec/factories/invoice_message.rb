FactoryBot.define do
  factory :invoice_message, class: Harvest::InvoiceMessage do
    body 'The message body goes here'
    recipients 'john@example.com, jane@example.com'
    attach_pdf true
    send_me_a_copy true
    include_pay_pal_link true
  end
end
