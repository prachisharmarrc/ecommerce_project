class OrderTax < ApplicationRecord
  belongs_to :order
  belongs_to :tax

  validates :tax_amount, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "tax_id", "tax_amount", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order", "tax"]
  end
end
