class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items

  validates :image_url, presence: true

  scope :search, ->(query) { where("product_name LIKE ?", "%#{query}%") if query.present? }
end
