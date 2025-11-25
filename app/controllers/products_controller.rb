class ProductsController < ApplicationController
  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products.includes(:category).order(created_at: :desc)
    else
      @products = Product.includes(:category).order(created_at: :desc)
      @category = nil
    end

    @categories = Category.all.order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end
end