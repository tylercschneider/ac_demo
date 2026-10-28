require "test_helper"

class BalancesOtherUsersExcludedTest < ActionDispatch::IntegrationTest
  test "another user's unpaid invoice is not counted in the caller's outstanding balance" do
    users(:alice).invoices.create!(invoice_id: "INV-1003", date: "2026-03-01", amount: "75.00", status: "open")

    get "/api/balance", headers: { "Authorization" => "Bearer tok-bob" }

    assert_response :ok
    assert_equal BigDecimal("90.00"), BigDecimal(JSON.parse(response.body)["outstanding_balance"].to_s)
  end
end
