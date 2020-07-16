require 'test_helper'

class BootsTest < ActiveSupport::TestCase
  class TritaryService < ActiveDuty::Base
  end

  class SecondaryService < ActiveDuty::Base
  end

  class PrimaryService < ActiveDuty::Base
    init_with :name

    boots SecondaryService
    boots TritaryService
  end

  test "complete callback chain" do
    duty = PrimaryService.new("Josh")
    duty.call
    assert_equal duty.send(:called), ["BootsTest::PrimaryService", "BootsTest::SecondaryService", "BootsTest::TritaryService"]
  end
end
