class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart
  
  def new
    if @cart.empty?
      redirect_to cart_path, alert: "Your cart is empty"
      return
    end
    
    @cart_items = []
    @subtotal = 0
    
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        item_price = product.on_sale? ? product.sale_price : product.price
        @cart_items << {
          product: product,
          quantity: quantity,
          price: item_price,
          subtotal: item_price * quantity
        }
        @subtotal += item_price * quantity
      end
    end
    
    # Get or create user's address
    @address = current_user.address || current_user.build_address
    @provinces = Province.all.order(:name)
    
    # Calculate taxes if address exists
    if @address.province
      calculate_taxes(@subtotal, @address.province)
    end
  end
  
  def create
    if @cart.empty?
      redirect_to cart_path, alert: "Your cart is empty"
      return
    end
    
    # Save or update address if provided
    if params[:street_address].present?
      address = current_user.address || current_user.build_address
      address.update!(
        street_address: params[:street_address],
        city: params[:city],
        postal_code: params[:postal_code],
        province_id: params[:province_id]
      )
    end
    
    # Calculate totals
    subtotal = 0
    line_items = []
    
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      
      item_price = product.on_sale? ? product.sale_price : product.price
      subtotal += item_price * quantity
      
      line_items << {
        price_data: {
          currency: 'cad',
          product_data: {
            name: product.name,
          },
          unit_amount: (item_price * 100).to_i,
        },
        quantity: quantity,
      }
    end
    
    # Create Stripe checkout session
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: url_for(controller: 'checkout', action: 'success', only_path: false) + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: cart_url,
      customer_email: current_user.email,
    })
    
    redirect_to session.url, allow_other_host: true
    
  rescue Stripe::StripeError => e
    redirect_to checkout_path, alert: "Payment error: #{e.message}"
  end
  
  def success
    session_id = params[:session_id]
    
    if session_id
      begin
        # Retrieve the checkout session from Stripe
        stripe_session = Stripe::Checkout::Session.retrieve(session_id)
        
        # Calculate subtotal from cart
        subtotal = 0
        @cart.each do |product_id, quantity|
          product = Product.find_by(id: product_id)
          next unless product
          item_price = product.on_sale? ? product.sale_price : product.price
          subtotal += item_price * quantity
        end
        
        # Get user's address for tax calculation and saving to order
        address = current_user.address
        province = address&.province
        taxes = calculate_taxes(subtotal, province)
        
        # Create order with tax breakdown AND address details
        order = current_user.orders.create!(
          status: 'paid',
          subtotal: subtotal,
          gst: taxes[:gst],
          pst: taxes[:pst],
          hst: taxes[:hst],
          total: taxes[:total],
          stripe_payment_intent_id: stripe_session.payment_intent,
          street_address: address&.street_address,
          city: address&.city,
          postal_code: address&.postal_code,
          province_id: address&.province_id
        )
        
        # Create order items
        @cart.each do |product_id, quantity|
          product = Product.find_by(id: product_id)
          next unless product
          
          item_price = product.on_sale? ? product.sale_price : product.price
          
          order.order_items.create!(
            product: product,
            quantity: quantity,
            price_at_purchase: item_price
          )
          
          # Reduce stock
          product.update!(stock_quantity: product.stock_quantity - quantity)
        end
        
        # Clear cart
        session[:cart] = {}
        
        @order = order
        
      rescue Stripe::StripeError => e
        redirect_to root_path, alert: "Error processing order: #{e.message}"
      end
    else
      redirect_to root_path, alert: "Invalid checkout session"
    end
  end
  
  private
  
  def initialize_cart
    @cart = session[:cart] ||= {}
  end
  
  def calculate_taxes(subtotal, province)
    return { gst: 0, pst: 0, hst: 0, total: subtotal } unless province
    
    gst = (subtotal * province.gst_rate).round(2)
    pst = (subtotal * province.pst_rate).round(2)
    hst = (subtotal * province.hst_rate).round(2)
    total = (subtotal + gst + pst + hst).round(2)
    
    @gst = gst
    @pst = pst
    @hst = hst
    @total = total
    
    { gst: gst, pst: pst, hst: hst, total: total }
  end
end