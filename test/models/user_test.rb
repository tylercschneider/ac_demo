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

  test "a user's outstanding balance adds up all their unpaid invoices including decimal amounts" do
    user = User.create!(name: "Erin", api_token: "tok-erin")
    user.invoices.create!(invoice_id: "INV-4001", date: "2026-03-01", amount: "10.10", status: "open")
    user.invoices.create!(invoice_id: "INV-4002", date: "2026-03-02", amount: "20.20", status: "open")
    user.invoices.create!(invoice_id: "INV-4003", date: "2026-03-03", amount: "5.05", status: "open")

    assert_equal BigDecimal("35.35"), user.outstanding_balance.to_d
  end

  test "another user's unpaid invoice is not counted in the outstanding balance" do
    user = User.create!(name: "Gina", api_token: "tok-gina")
    other = User.create!(name: "Hal", api_token: "tok-hal")
    other.invoices.create!(invoice_id: "INV-6001", date: "2026-03-01", amount: "99.00", status: "open")

    assert_equal BigDecimal("0"), user.outstanding_balance.to_d
  end

  test "a paid invoice is not counted in the outstanding balance" do
    user = User.create!(name: "Frank", api_token: "tok-frank")
    user.invoices.create!(invoice_id: "INV-5001", date: "2026-03-01", amount: "40.00", status: "paid")

    assert_equal BigDecimal("0"), user.outstanding_balance.to_d
  end
end
