require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "an invoice whose status is paid says it is paid" do
    invoice = Invoice.new(status: "paid")

    assert invoice.paid?
  end

  test "an invoice whose status is open does not say it is paid" do
    invoice = Invoice.new(status: "open")

    assert_not invoice.paid?
  end
end
