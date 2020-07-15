require 'test_helper'

class CallbackTest < ActiveSupport::TestCase
  class CallbackValidator
    def around_call(model)
      model.callbacks << :before_around_call
      yield
      model.callbacks << :after_around_call
      false
    end
  end

  class DutyCallbacks < ActiveDuty::Base
    attr_reader :callbacks
    after_initialize do |model|
      model.callbacks << :after_initialize
    end
    before_call :before_call

    after_call do |model|
      model.callbacks << :after_call
      false
    end

    def initialize(options = {})
      @callbacks = []
    end

    def before_call
      @callbacks << :before_call
    end

    def call
      run_callbacks :call do
        @callbacks << :call
      end
    end
  end

  test "complete callback chain" do
    duty = DutyCallbacks.new
    duty.call
    assert_equal duty.callbacks, [:after_initialize, :before_call, :call, :after_call]

  end
end
