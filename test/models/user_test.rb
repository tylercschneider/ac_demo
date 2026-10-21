require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user with no invoices has an outstanding balance of zero" do
    user = User.create!(name: "Carol", api_token: "tok-carol")

    assert_equal 0, user.outstanding_balance
  end

  test "outstanding balance is the sum of the amounts of a user's open invoices" do
    user = User.create!(name: "Dave", api_token: "tok-dave")
    user.invoices.create!(invoice_id: "INV-3001", date: "2026-03-01", amount: "100.50", status: "open")
    user.invoices.create!(invoice_id: "INV-3002", date: "2026-03-02", amount: "49.50", status: "open")

    assert_equal 150, user.outstanding_balance.to_d
  end
end
