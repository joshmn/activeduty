module ActiveDuty
  module Initializers
    extend ActiveSupport::Concern
    module ClassMethods
      def init_with(*args)
        kwargs = args.extract_options!

        if kwargs.empty?
          define_method :initialize do |*initialize_args|
            args.zip(initialize_args) do |name, value|
              instance_variable_set("@#{name}", value)
            end
            self.class.attr_reader *args
          end
        elsif kwargs.is_a?(Hash)
          class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def initialize(#{kwargs.keys.map { |key| "#{key}:" }.join(', ')})
              #{kwargs.map { |key, value| 
                "
                  instance_variable_set(:\"@#{value}\", #{key}) 
                  self.class.attr_reader :#{value}
                " 
                  }.join("\n")
                }
            end
          METHOD
        end

      end

    end

  end
end
