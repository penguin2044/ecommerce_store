ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :admin,
                address_attributes: [ :id, :street_address, :city, :province_id, :postal_code ]

  # Filters
  filter :email
  filter :first_name
  filter :last_name
  filter :created_at
  filter :updated_at

# Index page - list of users
index do
  selectable_column
  id_column
  column :email
  column :first_name
  column :last_name
  column "Full Address" do |user|
    if user.address
      "#{user.address.street_address}, #{user.address.city}, #{user.address.province.abbreviation} #{user.address.postal_code}"
    else
      "No address on file"
    end
  end
  column :created_at
  actions
end

  # Show page - individual user details
  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :admin
      row :created_at
      row :updated_at
    end

    panel "Shipping Address" do
      if user.address
        attributes_table_for user.address do
          row :street_address
          row :city
          row :province do |address|
            address.province.name
          end
          row :postal_code
        end
      else
        para "No address on file"
      end
    end

    panel "Orders" do
      table_for user.orders.order(created_at: :desc) do
        column "Order ID" do |order|
          link_to "##{order.id}", admin_order_path(order)
        end
        column :status
        column :total do |order|
          number_to_currency(order.total, unit: "$")
        end
        column :created_at
      end
    end
  end

  # Edit/Create form
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :admin, as: :boolean, label: "Administrator?"
    end

    f.inputs "Shipping Address" do
      f.has_many :address, allow_destroy: true, heading: false do |address_form|
        address_form.input :street_address
        address_form.input :city
        address_form.input :province, as: :select, collection: Province.all.order(:name)
        address_form.input :postal_code, placeholder: "A1A 1A1"
      end
    end

    f.actions
  end
end
