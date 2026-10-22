require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user with no invoices has an outstanding balance of zero" do
    user = User.create!(name: "Carol", api_token: "tok-carol")

    assert_equal 0, user.outstanding_balance
  end

  test "a user's outstanding balance is the amount of a single unpaid invoice" do
    user = User.create!(name: "Dave", api_token: "tok-dave")
    user.invoices.create!(invoice_id: "INV-3001", date: "2026-03-01", amount: "75.50", status: "open")

    assert_equal BigDecimal("75.50"), user.outstanding_balance.to_d
  end
end
