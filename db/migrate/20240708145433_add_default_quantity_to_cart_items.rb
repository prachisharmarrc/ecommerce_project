class AddDefaultQuantityToCartItems < ActiveRecord::Migration[6.1]
  def change
    change_column_default :cart_items, :quantity, 1
  end
end
