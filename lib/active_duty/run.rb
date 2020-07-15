module ActiveDuty
  module Run
    extend ActiveSupport::Concern
    def call(*args)
      begin #
        call!(*args)
      rescue => error
        rollback!
        if error.is_a?(Failure)
          self.errors.add(:base, error.message)
          return self
        end
        raise error
      end
      self
    end

    def call!(*args)
      run(*args)
      self
    end

    module ClassMethods
      def run(*args, &block)
        define_method :run do |*args|
          self.instance_exec *args, &block
        end
      end

      def call(*args)
        new(*args).call
      end

      def call!(*args)
        new(*args).call!
      end
    end
  end
end
