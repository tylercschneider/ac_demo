require "bigdecimal"

class User < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def paid_total
    invoices.where(status: "paid").sum { |invoice| BigDecimal(invoice.amount) }
  end
end
