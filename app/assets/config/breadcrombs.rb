# config/breadcrumbs.rb

# Root breadcrumb
crumb :root do
  link "Home", root_path
end

# Products index
crumb :products do
  link "Home", root_path
  link "All Products", root_path
end

# Products by category
crumb :category do |category|
  link "Home", root_path
  link "All Products", root_path
  link category.name, root_path(category_id: category.id)
end

# Individual product
crumb :product do |product|
  link "Home", root_path
  link "All Products", root_path
  link product.category.name, root_path(category_id: product.category_id)
  link product.name, product_path(product)
end

# Shopping cart
crumb :cart do
  link "Home", root_path
  link "Shopping Cart", cart_path
end

# Checkout
crumb :checkout do
  link "Home", root_path
  link "Shopping Cart", cart_path
  link "Checkout", checkout_path
end

# Orders list
crumb :orders do
  link "Home", root_path
  link "My Orders", orders_path
end

# Individual order
crumb :order do |order|
  link "Home", root_path
  link "My Orders", orders_path
  link "Order ##{order.id}", order_path(order)
end

# About page
crumb :about do
  link "Home", root_path
  link "About Us", about_path
end

# Contact page
crumb :contact do
  link "Home", root_path
  link "Contact Us", contact_path
end