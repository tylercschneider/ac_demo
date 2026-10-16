require "test_helper"

class OverdueInvoicesTest < ActionDispatch::IntegrationTest
  test "GET /api/invoices/overdue lists only the user's overdue invoices" do
    alice = users(:alice)
    alice.invoices.create!(invoice_id: "INV-OVERDUE", date: 10.days.ago.to_date.to_s, amount: "10.00", status: "open")
    alice.invoices.create!(invoice_id: "INV-FUTURE", date: 10.days.from_now.to_date.to_s, amount: "10.00", status: "open")

    get "/api/invoices/overdue", headers: { "Authorization" => "Bearer tok-alice" }

    assert_response :ok
    ids = JSON.parse(response.body).map { |i| i["invoice_id"] }
    assert_equal [ "INV-OVERDUE" ], ids
  end
end
