class User < ApplicationRecord
  has_many :invoices, dependent: :destroy
end
