class CartController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = []
    @total = 0

    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        item_price = product.on_sale? ? product.sale_price : product.price
        @cart_items << {
          product: product,
          quantity: quantity,
          subtotal: item_price * quantity
        }
        @total += item_price * quantity
      end
    end
  end

  def add
    product = Product.find(params[:id])

    if product.stock_quantity > 0
      if @cart[product.id.to_s]
        # Product already in cart, increment quantity
        current_quantity = @cart[product.id.to_s]
        if current_quantity < product.stock_quantity
          @cart[product.id.to_s] += 1
          set_secure_flash(:notice, "Added another #{product.name} to cart")        else
          set_secure_flash(:alert, "Cannot add more - only #{product.stock_quantity} in stock")
        end
      else
        # Add new product to cart
        @cart[product.id.to_s] = 1
        flash[:notice] = "#{product.name} added to cart"
      end
    else
      flash[:alert] = "#{product.name} is out of stock"
    end

    session[:cart] = @cart
    redirect_back(fallback_location: root_path)
  end

  def remove
    product = Product.find(params[:id])
    @cart.delete(product.id.to_s)
    session[:cart] = @cart

    flash[:notice] = "#{product.name} removed from cart"
    redirect_to cart_path
  end

  def update_quantity
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if quantity > 0 && quantity <= product.stock_quantity
      @cart[product.id.to_s] = quantity
      session[:cart] = @cart
      flash[:notice] = "Quantity updated"
    elsif quantity > product.stock_quantity
      flash[:alert] = "Only #{product.stock_quantity} in stock"
    else
      flash[:alert] = "Invalid quantity"
    end

    redirect_to cart_path
  end

  def clear
    session[:cart] = {}
    flash[:notice] = "Cart cleared"
    redirect_to cart_path
  end

  private

  def initialize_cart
    @cart = session[:cart] ||= {}
  end
end