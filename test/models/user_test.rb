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

  test "another customer's unpaid invoice is not counted in the customer's outstanding balance" do
    user = User.create!(name: "Frank", api_token: "tok-frank")
    other = User.create!(name: "Gina", api_token: "tok-gina")
    other.invoices.create!(invoice_id: "INV-5001", date: "2026-05-01", amount: "200.00", status: "open")

    assert_equal 0, user.outstanding_balance
  end

  test "a paid invoice is not counted in the customer's outstanding balance" do
    user = User.create!(name: "Erin", api_token: "tok-erin")
    user.invoices.create!(invoice_id: "INV-4001", date: "2026-04-01", amount: "75.00", status: "paid")

    assert_equal 0, user.outstanding_balance
  end
end
