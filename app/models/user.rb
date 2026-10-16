class User < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def outstanding_balance
    invoices.where.not(status: "paid").sum { |invoice| invoice.amount.to_d }
  end
end
