class InvoicesController < ApplicationController
  # GET /api/invoices/export
  def export
    invoices = Invoice.order(:invoice_id) # BUG: every user's invoices, and no auth
    header = "invoice_id,date,amount,status"
    rows = invoices.map { |i| [i.invoice_id, i.date, i.amount, i.status].join(",") }
    send_data ([header] + rows).join("\n"), type: "text/csv", status: :ok
  end
end
