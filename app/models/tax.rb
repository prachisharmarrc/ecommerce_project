# app/models/tax.rb
class Tax < ApplicationRecord
    has_many :order_taxes
    has_many :orders, through: :order_taxes
  
    validates :region, :tax_type, :tax_rate, presence: true
  end
  