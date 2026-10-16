require "test_helper"

class PaidTotalTest < ActionDispatch::IntegrationTest
  test "GET /api/invoices/paid_total returns the user's paid total and refuses requests without a valid token" do
    get "/api/invoices/paid_total", headers: { "Authorization" => "Bearer tok-alice" }

    assert_response :ok
    assert_equal BigDecimal("240.00"), BigDecimal(JSON.parse(response.body)["paid_total"].to_s)

    get "/api/invoices/paid_total"
    assert_response :unauthorized

    get "/api/invoices/paid_total", headers: { "Authorization" => "Bearer wrong" }
    assert_response :unauthorized
  end
end
