class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.total_price = current_user.cart.total_price
    if @order.save
      current_user.cart.cart_items.destroy_all
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
