class Tax < ApplicationRecord
    has_many :order_taxes
    has_many :orders, through: :order_taxes
  end
  