module Harvest
  module API
    class TimeEntry < Base
      include Harvest::Behavior::Crud

      api_model Harvest::TimeEntry

      def stop(time_entry)
        request(:put, credentials, "#{api_model.api_path}/#{time_entry.id}/stop")
        time_entry.id
      end

      def restart(time_entry)
        request(:put, credentials, "#{api_model.api_path}/#{time_entry.id}/restart")
        time_entry.id
      end
    end
  end
end
