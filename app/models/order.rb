class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  has_many :order_taxes
  has_many :taxes, through: :order_taxes

  def total_price
    order_items.sum { |item| item.quantity * item.price }
  end

  def applicable_taxes
    Tax.where(region: user.province)
  end
end
