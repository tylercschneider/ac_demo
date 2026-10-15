require "test_helper"

class CheerTest < ActiveSupport::TestCase
  test "for cheers a person on by name" do
    assert_equal "Go, Ada!", Cheer.for("Ada")
  end
end
