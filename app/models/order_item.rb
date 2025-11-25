class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price_at_purchase, presence: true, numericality: { greater_than: 0 }

  before_validation :set_price_at_purchase

  private

  def set_price_at_purchase
    self.price_at_purchase ||= product.on_sale ? product.sale_price : product.price
  end
end
