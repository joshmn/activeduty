require 'ostruct'

module ActiveDuty
  module Errors
    extend ActiveSupport::Concern

    included do
      extend ActiveModel::Naming
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end
  end
end
