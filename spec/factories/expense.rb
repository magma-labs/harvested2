FactoryBot.define do
  factory :expense, class: Harvest::Expense do
    notes 'Drive to Chicago'
    total_cost 75.0
    spent_at Time.utc(2009, 12, 28)
    expense_category
    project
  end
end

