FactoryBot.define do
  factory :contact, class: Harvest::Contact do
    client
    email 'jane@example.com'
    first_name 'Jane'
    last_name 'Doe'
  end
end
