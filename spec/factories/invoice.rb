FactoryBot.define do
  factory :invoice, class: Harvest::Invoice do
    sequence(:id)
    subject "Invoice for Joe's Stream Cleaning"
    amount 2400.0
    issued_at '2014-01-01'
    due_at "2011-03-31"
    due_at_human_format 'upon receipt'
    currency 'United States Dollars - USD'
    number '1000'
    notes 'Some notes go here'
    period_end '2013-03-31'
    period_start '2013-02-26'
    kind 'free_form'
    state 'draft'
    purchase_order nil
    tax nil
    tax2 nil
    import_hours 'no'
    import_expenses 'no'

    client
  end
end

