require 'test_helper'

class FailTest < ActiveSupport::TestCase
  class FailService < ActiveDuty::Base
    run do
      fail!
    end
  end

  test "it fails" do
    service = FailService.call
    assert service.failure?
  end
end
