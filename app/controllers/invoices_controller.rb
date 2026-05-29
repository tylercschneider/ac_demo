class InvoicesController < ApplicationController
  # GET /api/invoices/export
  def export
    invoices = Invoice.order(:invoice_id) # BUG: returns every user's invoices
    header = "invoice_id,date,amount,status"
    rows = invoices.map do |i|
      [i.invoice_id, i.date, i.amount, i.status].join(",") # BUG: no escaping
    end
    send_data ([header] + rows).join("\n"), type: "text/csv", status: :ok
  end
end
