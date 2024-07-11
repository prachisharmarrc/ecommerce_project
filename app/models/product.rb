class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items
  has_one_attached :image

  validates :image, presence: true

  scope :search, ->(query) { where("product_name LIKE ?", "%#{query}%") if query.present? }

  def self.ransackable_associations(auth_object = nil)
    ["cart_items", "categories", "order_items", "orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["product_name", "description", "price", "stock_quantity", "created_at", "updated_at"]
  end
end
