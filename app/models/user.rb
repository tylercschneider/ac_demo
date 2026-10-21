class User < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def outstanding_balance
    invoices.sum { |invoice| BigDecimal(invoice.amount) }
  end
end
