require 'test_helper'

class RunTest < ActiveSupport::TestCase

  class RunAsBlockWithArgs < ActiveDuty::Base
    init_with :name
    run do |new_name|
      @name = new_name
    end
  end

  class RunAsBlockWithKwArgs < ActiveDuty::Base
    init_with :name
    run do |new_name:|
      @name = new_name
    end
  end

  class ClassCall < ActiveDuty::Base
    init_with :name
    run do
      # nothing
    end
  end

  test "call a block with args" do
    duty = RunAsBlockWithArgs.new("Josh")
    assert_equal "Josh", duty.name
    duty.run("Luiz")
    assert_equal "Luiz", duty.name
  end

  test "call a block with kwargs" do
    duty = RunAsBlockWithKwArgs.new("Josh")
    assert_equal "Josh", duty.name
    duty.run(new_name: "Luiz")
    assert_equal "Luiz", duty.name
  end

  test "self.call a block with args" do
    duty = ClassCall.call("Josh")
    assert_equal "Josh", duty.name
  end
end
