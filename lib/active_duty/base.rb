require 'active_duty/initializers'
require 'active_duty/run'
require 'active_duty/fail'
require 'active_duty/success'
require 'active_duty/callbacks'
require 'active_duty/context'
require 'active_duty/errors'
require 'active_duty/rollback'

module ActiveDuty
  class Base
    include Callbacks
    include Context
    include Errors
    include Fail
    include Initializers
    include Rollback
    include Run
    include Success

    class << self
      alias_method :__new, :new
      def new(*args)
        e = __new(*args)
        e.after_initialize!
        e
      end
    end
  end
end
