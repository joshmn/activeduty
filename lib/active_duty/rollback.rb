module ActiveDuty
  module Rollback
    extend ActiveSupport::Concern

    module ClassMethods
      def rollback(&block)
        @_rollback = block
      end

      def _rollback
        return unless defined?(@_rollback)
        @_rollback
      end
    end

    def rollback!
      if self.class._rollback
        instance_eval(&self.class._rollback)
      elsif self.respond_to?(:rollback)
        rollback
      end
    end
  end
end
