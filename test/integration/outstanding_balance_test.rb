require "test_helper"

class OutstandingBalanceTest < ActionDispatch::IntegrationTest
  test "GET /api/balance returns the user's outstanding balance and refuses requests without a valid token" do
    get "/api/balance", headers: { "Authorization" => "Bearer tok-bob" }
    assert_response :ok
    assert_equal 90.0, JSON.parse(response.body)["outstanding_balance"].to_d.to_f

    get "/api/balance"
    assert_response :unauthorized

    get "/api/balance", headers: { "Authorization" => "Bearer wrong" }
    assert_response :unauthorized
  end
end
