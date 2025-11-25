class Product < ApplicationRecord
 belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :on_sale, -> { where(on_sale: true) }
  scope :featured, -> { where(featured: true) }
  scope :in_stock, -> { where('stock_quantity > ?', 0) }
end
