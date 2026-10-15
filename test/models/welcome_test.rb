require "test_helper"

class WelcomeTest < ActiveSupport::TestCase
  test "for welcomes a person by name" do
    assert_equal "Welcome, Ada", Welcome.for("Ada")
  end

  test "for welcomes a friend when no name is given" do
    assert_equal "Welcome, friend", Welcome.for(nil)
  end
end
