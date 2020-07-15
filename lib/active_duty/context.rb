require 'ostruct'

module ActiveDuty
  module Context
    def context
      @context ||= OpenStruct.new
    end
  end
end
