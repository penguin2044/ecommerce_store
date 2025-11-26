class ProductsController < ApplicationController
  def index
    @categories = Category.all.order(:name)
    
    # Get recently updated and on-sale products for homepage
    @recently_updated_products = Product.where('updated_at >= ?', 3.days.ago).order(updated_at: :desc).limit(4)
    @on_sale_products = Product.on_sale.limit(4)
    
    # Start with all products
    @products = Product.includes(:category)
    
    # CATEGORY NAVIGATION (Feature 2.2) - Filter by clicking category tabs
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @products.where(category_id: @category.id)
    else
      @category = nil
    end
    
    # KEYWORD SEARCH WITH CATEGORY DROPDOWN (Feature 2.4)
    # This is different from 2.2 because it uses a search form with dropdown
    if params[:search].present? || params[:search_category_id].present?
      # Keyword search
      if params[:search].present?
        search_term = "%#{params[:search]}%"
        @products = @products.where(
          "name ILIKE ? OR description ILIKE ?", 
          search_term, 
          search_term
        )
        @search_query = params[:search]
      end
      
      # Category filter from search dropdown
      if params[:search_category_id].present?
        @products = @products.where(category_id: params[:search_category_id])
      end
    end
    
    # Paginate results - 12 per page
    @products = @products.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end