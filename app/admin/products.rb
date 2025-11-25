ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :stock_quantity,
                :on_sale, :sale_price, :featured
  
  # Remove problematic association filters
  remove_filter :order_items
  remove_filter :orders
  remove_filter :images_attachments
  remove_filter :images_blobs
  
  # Customize the index page to show stock quantity prominently
  index do
    selectable_column
    id_column
    column :name
    column :category
    column :price do |product|
      number_to_currency(product.price)
    end
    column :stock_quantity do |product|
      if product.stock_quantity == 0
        status_tag("OUT OF STOCK", :error)
      elsif product.stock_quantity < 5
        status_tag("#{product.stock_quantity} - LOW STOCK", :warning)
      else
        status_tag("#{product.stock_quantity} in stock", :ok)
      end
    end
    column :on_sale
    column :featured
    actions
  end
  
  # Customize the form to make stock quantity easy to update
  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :category
      f.input :price, hint: "Enter price without dollar sign"
      f.input :stock_quantity, hint: "Number of items in stock"
    end
    
    f.inputs "Sale Information" do
      f.input :on_sale, label: "On Sale?"
      f.input :sale_price, hint: "Only used if 'On Sale' is checked"
    end
    
    f.inputs "Featured" do
      f.input :featured, label: "Featured Product?"
    end
    
    f.actions
  end
  
  # Show page with clear stock information
  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :price do |product|
        number_to_currency(product.price)
      end
      row :stock_quantity do |product|
        if product.stock_quantity == 0
          status_tag("OUT OF STOCK", :error)
        elsif product.stock_quantity < 5
          status_tag("#{product.stock_quantity} - LOW STOCK", :warning)
        else
          status_tag("#{product.stock_quantity} in stock", :ok)
        end
      end
      row :on_sale
      row :sale_price do |product|
        number_to_currency(product.sale_price) if product.on_sale?
      end
      row :featured
      row :created_at
      row :updated_at
    end
  end
end