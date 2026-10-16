require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "outstanding balance totals unpaid invoice amounts and ignores paid invoices" do
    user = User.create!(name: "Carol", api_token: "tok-carol")
    user.invoices.create!(invoice_id: "INV-3001", date: "2026-03-01", amount: "50.25", status: "open")
    user.invoices.create!(invoice_id: "INV-3002", date: "2026-03-02", amount: "30.00", status: "open")
    user.invoices.create!(invoice_id: "INV-3003", date: "2026-03-03", amount: "500.00", status: "paid")

    assert_equal BigDecimal("80.25"), user.outstanding_balance.to_d
  end
end
