class Invoice < ApplicationRecord
  belongs_to :user

  def overdue?
    Date.parse(date) < Date.current && status != "paid"
  end
end
