require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a customer with no invoices has an outstanding balance of zero" do
    user = User.create!(name: "Carol", api_token: "tok-carol")

    assert_equal 0, user.outstanding_balance
  end

  test "a customer's outstanding balance adds up the amount of each unpaid invoice" do
    user = User.create!(name: "Dave", api_token: "tok-dave")
    user.invoices.create!(invoice_id: "INV-3001", date: "2026-03-01", amount: "100.50", status: "open")
    user.invoices.create!(invoice_id: "INV-3002", date: "2026-03-02", amount: "50.25", status: "open")

    assert_equal BigDecimal("150.75"), user.outstanding_balance
  end
end
