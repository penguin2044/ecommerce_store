class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many_attached :images
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }  # Changed this line
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  scope :on_sale, -> { where(on_sale: true) }
  scope :featured, -> { where(featured: true) }
  scope :in_stock, -> { where('stock_quantity > ?', 0) }
  
  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "category_id", "stock_quantity", "on_sale", "sale_price", "featured", "created_at", "updated_at", "id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end