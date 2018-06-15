FactoryBot.define do
  factory :project_assignment, class: Harvest::ProjectAssignment do
    is_project_manager true
    is_active true
    budget nil
    hourly_rate 100.0

    project
    client
  end
end
