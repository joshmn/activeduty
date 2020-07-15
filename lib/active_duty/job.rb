module ActiveDuty
  if Object.const_defined?(ActiveDuty.job_parent_class)
    class Job < Object.const_get(ActiveDuty.job_parent_class)
      def perform(klass, *args)
        klass.call!(args)
      end
    end
  else
    puts "#{ActiveDuty.job_parent_class} not defined. No job."
  end
end
