require "test_helper"

class ThanksTest < ActiveSupport::TestCase
  test "for thanks a person by name" do
    assert_equal "Thank you, Ada", Thanks.for("Ada")
  end
end
