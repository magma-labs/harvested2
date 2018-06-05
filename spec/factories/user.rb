FactoryBot.define do
  factory :user, class: Harvest::User do
    sequence(:id)
    first_name 'Edgar'
    last_name 'Ruth'
    email 'edgar@ruth.com'
    timezone 'cst'
    is_admin 'false'
    telephone '444-4444'

    trait :active do
      is_active true
    end

    trait :deactive do
      is_active false
    end
  end
end
