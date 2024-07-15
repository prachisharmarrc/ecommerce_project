class Tax < ApplicationRecord
    has_many :order_taxes
    has_many :orders, through: :order_taxes
  
    validates :region, :tax_type, :tax_rate, presence: true
    validates :tax_rate, numericality: { greater_than_or_equal_to: 0 }
  end
  