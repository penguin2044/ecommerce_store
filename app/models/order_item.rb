class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_at_purchase, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :order_id, presence: true
  validates :product_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "order_id", "product_id", "quantity", "price_at_purchase", "created_at", "updated_at", "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order", "product" ]
  end
end
