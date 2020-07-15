module ActiveDuty
  module CallAsync
    extend ActiveSupport::Concern

    def call_async(*args)
      self.class.call_async(*args)
    end

    module ClassMethods
      def call_async(*args)
        ActiveDuty.async_job.perform_async(self.name, *args)
      end
    end
  end
end
