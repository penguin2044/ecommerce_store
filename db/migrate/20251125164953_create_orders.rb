class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :gst, precision: 10, scale: 2
      t.decimal :pst, precision: 10, scale: 2
      t.decimal :hst, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.string :stripe_payment_intent_id

      t.timestamps
    end

    add_index :orders, :status
    add_index :orders, :stripe_payment_intent_id
  end
end