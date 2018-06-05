FactoryBot.define do
  factory :project, class: Harvest::Project do
    name 'Project Test'
    notes 'project to test the api'
    client

    trait :active do
      active true
    end

    trait :deactive do
      active false
    end
  end
end
