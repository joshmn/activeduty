module ActiveDuty
  module Callbacks
    extend ActiveSupport::Concern
    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :call, only: [:before, :after, :around]

      def self.after_initialize(&block)
        @_after_initialize_callbacks ||= []
        @_after_initialize_callbacks << block
      end

      def self._after_initialize_callbacks
        if defined?(@_after_initialize_callbacks)
          @_after_initialize_callbacks
        else
          nil
        end
      end

      def after_initialize!
        if self.class._after_initialize_callbacks
          self.class._after_initialize_callbacks.each do |callback|
            if callback.is_a?(Symbol)
              send(callback)
            else
              instance_exec(self, &callback)
            end
          end
        end
      end
    end
  end
end
