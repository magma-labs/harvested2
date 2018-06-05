FactoryBot.define do
  factory :user_project_assignment, class: Harvest::UserProjectAssignment do
    hourly_rate 120
    project
    user
  end
end
