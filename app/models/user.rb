class User < ApplicationRecord
    belongs_to :province
  
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    has_many :orders, dependent: :destroy
    has_one :cart
  end
  