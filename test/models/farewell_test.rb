require "test_helper"

class FarewellTest < ActiveSupport::TestCase
  test "for says goodbye to a person by name" do
    assert_equal "Goodbye, Ada", Farewell.for("Ada")
  end
end
