require "test_helper"

class BalancesAllPaidTest < ActionDispatch::IntegrationTest
  test "user whose invoices are all paid gets an outstanding balance of zero" do
    get "/api/balance", headers: { "Authorization" => "Bearer tok-alice" }

    assert_response :ok
    assert_equal 0, BigDecimal(JSON.parse(response.body)["outstanding_balance"].to_s)
  end
end
