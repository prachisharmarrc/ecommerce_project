class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :price, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end

  # Optionally, you can also define ransackable associations if needed
  def self.ransackable_associations(auth_object = nil)
    ["order", "product"]
  end
end
