class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :stock_quantity, default: 0
      t.boolean :on_sale, default: false
      t.decimal :sale_price, precision: 10, scale: 2
      t.boolean :featured, default: false

      t.timestamps
    end

    add_index :products, :name
    add_index :products, :on_sale
    add_index :products, :featured
  end
end