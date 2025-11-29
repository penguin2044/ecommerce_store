ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :stock_quantity,
                :on_sale, :sale_price, :featured, tag_ids: [], images: []
  
  # Remove problematic association filters
  remove_filter :order_items
  remove_filter :orders
  remove_filter :images_attachments
  remove_filter :images_blobs
  
  # Customize the index page to show stock quantity
  index do
    selectable_column
    id_column
    column :name
    column :category
    column :price do |product|
      number_to_currency(product.price)
    end
    column :stock_quantity
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
      f.input :images, as: :file, input_html: { multiple: true }
    end
    
    f.inputs "Sale Information" do
      f.input :on_sale, label: "On Sale?"
      f.input :sale_price, hint: "Only used if 'On Sale' is checked"
    end
    
    f.inputs "Featured" do
      f.input :featured, label: "Featured Product?"
      f.input :tags, as: :check_boxes, collection: Tag.all.order(:name)
    end
    
    f.actions
  end
end