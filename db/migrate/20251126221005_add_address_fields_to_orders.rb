class AddAddressFieldsToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :province_id, :integer
  end
end
