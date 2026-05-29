require "test_helper"

# Each test maps to one acceptance criterion in acceptance/spec.yml (by method
# name), so the runner can execute and report them per-criterion.
class InvoicesExportTest < ActionDispatch::IntegrationTest
  AUTH = { "Authorization" => "Bearer tok-alice" }.freeze

  # ac-1
  def test_ac_1_status_and_content_type
    get "/api/invoices/export", headers: AUTH
    assert_response :ok
    assert_equal "text/csv", response.media_type
  end

  # ac-2
  def test_ac_2_csv_header
    get "/api/invoices/export", headers: AUTH
    assert_equal "invoice_id,date,amount,status", response.body.lines.first.chomp
  end

  # ac-3
  def test_ac_3_user_scoping
    get "/api/invoices/export", headers: AUTH
    assert_not_includes response.body, "INV-2001", "must not include another user's invoice"
    data_rows = response.body.lines.drop(1)
    assert_equal 2, data_rows.size, "should return exactly the caller's two invoices"
  end

  # ac-4
  def test_ac_4_unauthenticated_401
    get "/api/invoices/export"
    assert_response :unauthorized
  end
end
