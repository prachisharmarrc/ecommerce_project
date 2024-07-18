class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :order_taxes, dependent: :destroy
  has_many :taxes, through: :order_taxes

  validates :address, :city, :province_id, :postal_code, presence: true
  validates :address, :city, :postal_code, length: { maximum: 255 }
  validates :province_id, numericality: { only_integer: true }
  # validates :address, presence: true

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
    if province.nil?
      Rails.logger.debug "Order #{id} has no associated province."
      []
    else
      Rails.logger.debug "Order #{id} has province: #{province.abbreviation}."
      taxes = Tax.where(region: province.abbreviation)
      Rails.logger.debug "Applicable taxes: #{taxes.inspect}"
      taxes
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total_price", "user_id", "address", "city", "province_id",
     "postal_code", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "products", "order_taxes", "taxes"]
  end
end
