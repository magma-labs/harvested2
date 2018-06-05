module HarvestedHelpers
  def self.clean_remote
    harvest = simple_harvest
    harvest.users.all.each do |u|
      harvest.reports.expenses_by_user(u, Time.utc(2000, 1, 1),
        Time.utc(2014, 6, 21)).each do |expense|
          harvest.expenses.delete(expense, u)
      end

      harvest.reports.time_by_user(u, Time.utc(2000, 1, 1),
        Time.utc(2014, 6, 21)).each do |time|
          harvest.time.delete(time, u)
      end
    end

    # we store expenses on this date in the tests
    harvest.expenses.all(Time.utc(2009, 12, 28)).each do |e|
      harvest.expenses.delete(e)
    end

    %w(expense_categories time projects invoices contacts
      clients tasks).each do |collection|
        harvest.send(collection).all.each do |m|
          harvest.send(collection).delete(m)
      end
    end
  end
end
