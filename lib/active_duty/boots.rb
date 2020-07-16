module ActiveDuty
  module Boots
    extend ActiveSupport::Concern

    included do
      self.class.attr_accessor :_boots
    end
    def deploy_troops!
      boots.each do |boot|
        klass = boot[:class_name].constantize
        boot = klass.new(*boot[:options][:args]).call
        called!(boot)
      end
    end

    def boots
      Array(self.class._boots)
    end

    module ClassMethods
      def boots(*args)
        @_boots ||= []
        options = args.extract_options!
        args.each do |boot|
          _boots << { class_name: boot.to_s, options: options }
        end
      end
    end
  end
end
