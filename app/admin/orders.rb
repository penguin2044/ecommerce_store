ActiveAdmin.register Order do
  # Remove problematic filters
  remove_filter :stripe_payment_intent_id
  remove_filter :order_items
  
  permit_params :status, :user_id
  
  index do
    selectable_column
    id_column
    column :user
    column "Shipping Address" do |order|
      if order.street_address.present?
        "#{order.street_address}, #{order.city}, #{order.province&.abbreviation} #{order.postal_code}"
      else
        "No address"
      end
    end
    column :status
    column :subtotal do |order|
      number_to_currency(order.subtotal)
    end
    column :gst do |order|
      number_to_currency(order.gst || 0)
    end
    column :pst do |order|
      number_to_currency(order.pst || 0)
    end
    column :hst do |order|
      number_to_currency(order.hst || 0)
    end
    column :total do |order|
      number_to_currency(order.total)
    end
    column "Stripe ID" do |order|
      order.stripe_payment_intent_id
    end
    column :created_at
    actions
  end
  
  show do
    attributes_table do
      row :id
      row :user
      row :status
      row "Shipping Address" do |order|
        if order.street_address.present?
          div do
            div order.street_address
            div "#{order.city}, #{order.province&.name} #{order.postal_code}"
          end
        else
          "No address saved"
        end
      end
      row :subtotal do |order|
        number_to_currency(order.subtotal)
      end
      row :gst do |order|
        number_to_currency(order.gst || 0)
      end
      row :pst do |order|
        number_to_currency(order.pst || 0)
      end
      row :hst do |order|
        number_to_currency(order.hst || 0)
      end
      row :total do |order|
        number_to_currency(order.total)
      end
      row :stripe_payment_intent_id
      row :created_at
      row :updated_at
    end
    
    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column "Price at Purchase" do |item|
          number_to_currency(item.price_at_purchase)
        end
        column "Subtotal" do |item|
          number_to_currency(item.quantity * item.price_at_purchase)
        end
      end
    end
  end
end