require "test_helper"

class BalancesUnpaidTotalTest < ActionDispatch::IntegrationTest
  test "outstanding balance is the total of the caller's unpaid invoice amounts" do
    users(:bob).invoices.create!(invoice_id: "INV-2002", date: "2026-02-09", amount: "35.50", status: "open")

    get "/api/balance", headers: { "Authorization" => "Bearer tok-bob" }

    assert_response :ok
    assert_equal BigDecimal("125.50"), BigDecimal(JSON.parse(response.body)["outstanding_balance"].to_s)
  end
end
