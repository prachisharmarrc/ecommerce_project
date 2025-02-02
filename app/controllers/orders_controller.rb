# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    redirect_to checkout_orders_path
  end

  def create
    @cart = current_user.cart
    @order = current_user.orders.build(order_params)
    @order.total_price = @cart.total_price

    if @order.save
      @cart.cart_items.each do |cart_item|
        @order.order_items.create!(
          product_id: cart_item.product_id,
          quantity:   cart_item.quantity,
          price:      cart_item.product.price
        )
      end

      @order.applicable_taxes.each do |tax|
        @order.order_taxes.create!(tax:, tax_amount: tax.tax_rate * @order.total_price)
      end

      @cart.cart_items.destroy_all

      begin
        # Send email notification
        OrderMailer.order_confirmation(@order).deliver_now
        flash[:notice] = "Order was successfully created and email sent."
      rescue StandardError => e
        Rails.logger.error "Failed to send order confirmation email: #{e.message}"
        flash[:alert] = "Order was successfully created but failed to send email notification."
      end

      redirect_to @order
    else
      flash[:alert] = "There was an error creating your order. Please try again."
      render :checkout
    end
  end

  def checkout
    @cart = current_user.cart
    @order = current_user.orders.build(
      address:     current_user.address,
      city:        current_user.city,
      province_id: current_user.province_id,
      postal_code: current_user.postal_code
    )
    @subtotal = @cart.total_price
    @taxes = @order.applicable_taxes.sum { |tax| tax.tax_rate * @subtotal }
    @total = @subtotal + @taxes
  end

  private

  def order_params
    params.require(:order).permit(:status, :address, :city, :province_id, :postal_code)
  end
end
