class Province < ApplicationRecord
    has_many :users
    validates :name, :abbreviation, presence: true
  end
  