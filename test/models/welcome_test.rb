require "test_helper"

class WelcomeTest < ActiveSupport::TestCase
  test "for welcomes a person by name" do
    assert_equal "Welcome, Ada", Welcome.for("Ada")
  end
end
