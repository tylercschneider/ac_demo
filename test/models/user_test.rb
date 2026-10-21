require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a customer with no invoices has an outstanding balance of zero" do
    user = User.create!(name: "Carol", api_token: "tok-carol")

    assert_equal 0, user.outstanding_balance
  end
end
