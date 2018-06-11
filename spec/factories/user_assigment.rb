FactoryBot.define do
  factory :user_assignment, class: Harvest::UserAssignment do
    hourly_rate 120
    project
    user
  end
end
