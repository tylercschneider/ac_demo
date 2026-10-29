class Invoice < ApplicationRecord
  belongs_to :user

  def paid?
    status == "paid"
  end
end
