class RemoveCategoryIdFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :category_id, :integer
  end
end
