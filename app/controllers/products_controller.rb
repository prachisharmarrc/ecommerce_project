class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.where("product_name LIKE ?", "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
