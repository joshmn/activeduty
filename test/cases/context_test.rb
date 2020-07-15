require 'test_helper'
require 'duties/naked_duty'

class ContextTest < ActiveSupport::TestCase
  test "has context" do
    duty = NakedDuty.new
    assert duty.context.is_a?(OpenStruct)
  end
end
