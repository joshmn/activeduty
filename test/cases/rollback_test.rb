require "test_helper"
require "duties/error_duty"

class RollbackTest < ActiveSupport::TestCase
  class RollbackService < ActiveDuty::Base
    init_with :name

    run do
      fail!
    end

    rollback do
      @name = "Old name"
    end
  end
  test "rolls back" do
    duty = RollbackService.new("Josh")
    duty.call
    assert_equal "Old name", duty.name
  end
end
