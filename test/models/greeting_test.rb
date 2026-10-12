require "test_helper"

class GreetingTest < ActiveSupport::TestCase
  test "for greets a person by name" do
    assert_equal "Hello, Ada", Greeting.for("Ada")
  end
end
