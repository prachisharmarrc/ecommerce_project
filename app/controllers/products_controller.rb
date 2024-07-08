class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where('product_name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category_id].present?
      @products = @products.joins(:categories).where(categories: { id: params[:category_id] })
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
