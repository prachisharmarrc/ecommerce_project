class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where('product_name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present?
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end

    if params[:filter].present?
      case params[:filter]
      when 'on_sale'
        @products = @products.on_sale
      when 'new'
        @products = @products.new_products
      when 'recently_updated'
        @products = @products.recently_updated
      end
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
