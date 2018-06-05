FactoryBot.define do
  factory :task_assignment, class: Harvest::TaskAssignment do
    hourly_rate 120
    project
    task
  end
end

