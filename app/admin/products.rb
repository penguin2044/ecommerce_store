ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :stock_quantity,
                :on_sale, :sale_price, :featured

  # Remove problematic association filters
  remove_filter :order_items
  remove_filter :orders
  remove_filter :images_attachments
  remove_filter :images_blobs
end