class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :order_taxes, dependent: :destroy
  has_many :taxes, through: :order_taxes

  validates :address, :city, :province, :postal_code, presence: true

  def total_price
    order_items.sum { |item| item.quantity * item.price }
  end

  def total_taxes
    applicable_taxes.sum { |tax| tax.tax_rate * total_price }
  end

  def total_amount
    total_price + total_taxes
  end

  def applicable_taxes
    Tax.where(region: province)
  end
end
