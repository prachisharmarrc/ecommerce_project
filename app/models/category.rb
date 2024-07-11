class Category < ApplicationRecord
    has_and_belongs_to_many :products
  
    validates :category_name, presence: true
    def self.ransackable_attributes(auth_object = nil)
        ["category_name", "created_at", "id", "updated_at"]
      end
    
      # Optionally, you can also define ransackable associations if needed
      def self.ransackable_associations(auth_object = nil)
        ["products"]
      end

  end
  