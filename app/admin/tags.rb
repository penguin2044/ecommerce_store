ActiveAdmin.register Tag do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column "Products Count" do |tag|
      tag.products.count
    end
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "Tag Details" do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      row "Products with this tag" do |tag|
        tag.products.count
      end
    end

    panel "Products with this Tag" do
      table_for tag.products.order(:name) do
        column :name do |product|
          link_to product.name, admin_product_path(product)
        end
        column :category
        column :price do |product|
          number_to_currency(product.price, unit: "$")
        end
      end
    end
  end
end
