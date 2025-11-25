class ProductsController < ApplicationController
  def index
    @categories = Category.all.order(:name)
    
    # Get featured and on-sale products for homepage
    @featured_products = Product.featured.limit(4)
    @on_sale_products = Product.on_sale.limit(4)
    
    # Start with all products
    @products = Product.includes(:category)
    
    # Filter by category if selected
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @products.where(category_id: @category.id)
    else
      @category = nil
    end
    
    # Filter by search query if present
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @products = @products.where(
        "name ILIKE ? OR description ILIKE ?", 
        search_term, 
        search_term
      )
      @search_query = params[:search]
    end
    
    # Paginate results - 12 per page
    @products = @products.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end