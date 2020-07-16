require "test_helper"
require "duties/init_with_array_arguments_duty"
require "duties/init_with_hash_arguments_duty"

class InitializersTest < ActiveSupport::TestCase
  test "initializes with array arguments" do
    service = InitWithArrayArgumentsDuty.new("Josh", 123)
    assert_equal"Josh",  service.name
    assert_equal 123, service.number
  end

  test "initializes with hash arguments" do
    service = InitWithHashArgumentsDuty.new(full_name: "Josh", num: 123)
    assert_equal"Josh", service.name
    assert_equal 123, service.number
  end

  class InitWithHashDefaultArgumentsDuty < ActiveDuty::Base
    init_with name: ["Josh", :name]
  end

  test "initializes with kwargs with defaults" do
    service = InitWithHashDefaultArgumentsDuty.new
    assert_equal "Josh", service.name
  end

  class InitWithArrayDefaultArgumentsDuty < ActiveDuty::Base
    init_with :age, [:name, "Josh"], [:options, {}]
  end

  test "initializes with ordered args with defaults" do
    service = InitWithArrayDefaultArgumentsDuty.new(123)
    assert_equal "Josh", service.name
    assert_equal 123, service.age
  end
end
