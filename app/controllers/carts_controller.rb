class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || Cart.create(user: current_user)
  end

  def add_product
    @cart = current_user.cart || Cart.create(user: current_user)
    cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    cart_item.quantity += 1
    cart_item.save
    redirect_to cart_path
  end

  def update_quantity
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  def remove_item
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path
  end
end
