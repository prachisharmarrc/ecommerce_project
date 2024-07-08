class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_price
    cart_items.includes(:product).reduce(0) do |sum, cart_item|
      sum + (cart_item.product.price * cart_item.quantity)
    end
  end
end
