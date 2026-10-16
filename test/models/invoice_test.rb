require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "an unpaid invoice dated before today is overdue" do
    invoice = Invoice.new(
      user: users(:alice),
      invoice_id: "INV-9001",
      date: 1.day.ago.to_date.to_s,
      amount: "50.00",
      status: "open"
    )

    assert invoice.overdue?
  end
end
