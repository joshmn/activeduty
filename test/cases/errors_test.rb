require "test_helper"
require "duties/error_duty"

class ErrorsTest < ActiveSupport::TestCase
  test "has errors" do
    duty = ErrorDuty.new
    duty.call
    assert_not_nil duty.errors.include?(:base)
    assert_equal "is invalid", duty.errors[:base][0]
  end
end
