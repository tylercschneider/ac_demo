require "test_helper"

class BalancesPaidExcludedTest < ActionDispatch::IntegrationTest
  test "a paid invoice is not counted in the caller's outstanding balance" do
    users(:bob).invoices.create!(invoice_id: "INV-2003", date: "2026-02-10", amount: "40.00", status: "paid")

    get "/api/balance", headers: { "Authorization" => "Bearer tok-bob" }

    assert_response :ok
    assert_equal BigDecimal("90.00"), BigDecimal(JSON.parse(response.body)["outstanding_balance"].to_s)
  end
end
