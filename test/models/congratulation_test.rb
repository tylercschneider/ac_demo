require "test_helper"

class CongratulationTest < ActiveSupport::TestCase
  test "for congratulates a person by name" do
    assert_equal "Congratulations, Ada", Congratulation.for("Ada")
  end
end
