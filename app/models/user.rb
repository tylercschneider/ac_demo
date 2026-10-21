class User < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def outstanding_balance
    invoices.reject { |invoice| invoice.status == "paid" }.sum { |invoice| BigDecimal(invoice.amount) }
  end
end
