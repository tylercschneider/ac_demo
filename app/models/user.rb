class User < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def outstanding_balance
    0
  end
end
