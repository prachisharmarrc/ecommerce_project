class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  validates :user_id, presence: true
  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def total_taxes
    applicable_taxes.sum { |tax| tax.tax_rate * total_price }
  end

  def total_amount
    total_price + total_taxes
  end

  def applicable_taxes
    Tax.where(region: user.province)
  end
  def total_taxes
    applicable_taxes.sum do |tax|
      tax_amount = tax.tax_rate * total_price
      puts "Calculating tax for #{tax.tax_type}: #{tax_amount}"
      tax_amount
    end
  end
  
end
