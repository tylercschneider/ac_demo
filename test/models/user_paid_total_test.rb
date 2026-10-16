require "test_helper"

class UserPaidTotalTest < ActiveSupport::TestCase
  test "paid_total sums the amounts of paid invoices and ignores unpaid ones" do
    user = User.create!(name: "Carol", api_token: "tok-carol")
    user.invoices.create!(invoice_id: "INV-3001", date: "2026-03-01", amount: "100.50", status: "paid")
    user.invoices.create!(invoice_id: "INV-3002", date: "2026-03-02", amount: "20.25", status: "paid")
    user.invoices.create!(invoice_id: "INV-3003", date: "2026-03-03", amount: "999.00", status: "open")

    assert_equal BigDecimal("120.75"), user.paid_total
  end
end
