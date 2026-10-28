require "test_helper"

class BalancesControllerTest < ActionDispatch::IntegrationTest
  test "authenticated request for outstanding balance returns 200 with a JSON body" do
    get "/api/balance", headers: { "Authorization" => "Bearer tok-alice" }

    assert_response :ok
    assert_match %r{\Aapplication/json}, response.media_type + ""
    assert_kind_of Hash, JSON.parse(response.body)
  end
end
