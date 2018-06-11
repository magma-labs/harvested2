FactoryBot.define do
  factory :time_entry, class: Harvest::TimeEntry do
    notes 'Test api support'
    hours 3
    spent_date '2009/12/28'
    task
    project

    trait :started do
      timer_started_at '2009/12/28'
    end
  end
end
