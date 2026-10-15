require "test_helper"

class CheerTest < ActiveSupport::TestCase
  test "for cheers a person on by name" do
    assert_equal "Go, Ada!", Cheer.for("Ada")
  end

  test "for cheers the team on when there is no name" do
    assert_equal "Go, team!", Cheer.for(nil)
  end

  test "loud cheers a person on in capitals" do
    assert_equal "GO, ADA!", Cheer.loud("Ada")
  end
end
