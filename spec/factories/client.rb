FactoryBot.define do
  factory :client, class: Harvest::Client do
    name 'John Doe'
    details "Steam Cleaning across the country"

    trait :active do
      active true
    end

    trait :deactive do
      active false
    end
  end
end
