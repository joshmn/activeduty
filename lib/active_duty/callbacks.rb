module ActiveDuty
  module Callbacks
    extend ActiveSupport::Concern
    included do
      extend ActiveModel::Callbacks
      define_model_callbacks :call, only: [:before, :after, :around]

      def self.after_initialize(&block)
        @_after_initialize_block = block
      end

      def self._after_initialize_block
        if defined?(@_after_initialize_block)
          @_after_initialize_block
        else
          nil
        end
      end

      def after_initialize!
        if self.class._after_initialize_block
          instance_exec(self, &self.class._after_initialize_block)
        end
      end
    end
  end
end
