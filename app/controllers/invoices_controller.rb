class InvoicesController < ApplicationController
  before_action :require_auth

  # GET /api/invoices/export
  # Returns the authenticated user's invoices as CSV.
  # CSV contract: header "invoice_id,date,amount,status", one row per invoice.
  def export
    invoices = @current_user.invoices.order(:invoice_id)
    header = "invoice_id,date,amount,status"
    rows = invoices.map do |i|
      [i.invoice_id, i.date, i.amount, i.status].map { |v| csv_escape(v) }.join(",")
    end
    send_data ([header] + rows).join("\n"),
              type: "text/csv; charset=utf-8",
              disposition: 'attachment; filename="invoices.csv"',
              status: :ok
  end

  private

  def csv_escape(value)
    s = value.to_s
    s.match?(/[",\n]/) ? %("#{s.gsub('"', '""')}") : s
  end
end
