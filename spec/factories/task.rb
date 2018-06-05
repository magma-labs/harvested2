FactoryBot.define do
  factory :task, class: Harvest::Task do
    name 'A crud task'
    billable_by_default true
    default_hourly_rate 120
  end
end

