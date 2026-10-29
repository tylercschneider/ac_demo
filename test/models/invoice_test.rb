require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "an invoice whose status is paid says it is paid" do
    invoice = Invoice.new(status: "paid")

    assert invoice.paid?
  end
end
