module ActiveDuty
  module Fail
    extend ActiveSupport::Concern

    def fail!
      @failure = true
      raise Failure, self
    end

    def failure?
      @failure == true || errors.any?
    end
  end
end
