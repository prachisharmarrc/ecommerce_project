class User < ApplicationRecord
    has_many :orders
    has_one :cart
  
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable  
end
