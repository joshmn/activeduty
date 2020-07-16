module ActiveDuty
  module Reported
    protected

    def called!(klass)
      klass._called = true
      called << klass.class.name
    end

    def called
      @called ||= []
    end

    def called?
      @_called
    end

    def _called=(value)
      @_called = value
    end
  end
end
