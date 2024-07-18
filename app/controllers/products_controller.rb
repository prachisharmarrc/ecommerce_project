# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("product_name LIKE ? OR description LIKE ?",
                                  "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present?
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end

    @products = filter_products(@products, params[:filter]) if params[:filter].present?

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def filter_products(products, filter)
    case filter
    when "on_sale"
      products.on_sale
    when "new"
      products.new_products
    when "recently_updated"
      products.recently_updated
    else
      products
    end
  end
end
