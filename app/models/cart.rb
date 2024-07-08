class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def total_tax
    # Assuming you have a Tax model with a `tax_rate` attribute
    taxes = Tax.where(region: user.province)
    taxes.sum { |tax| total_price * tax.tax_rate }
  end
end
