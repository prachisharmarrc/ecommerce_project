class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :set_default_quantity
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart_id, :product_id, presence: true
  private

  def set_default_quantity
    self.quantity ||= 1
  end
  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "id", "product_id", "quantity", "updated_at"]
  end

  # Optionally, you can also define ransackable associations if needed
  def self.ransackable_associations(auth_object = nil)
    ["cart", "product"]
  end
end
