class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  # has_many_attached :images
  
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true
  validates :on_sale, inclusion: { in: [true, false] }
  validates :featured, inclusion: { in: [true, false] }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0.01, allow_nil: true }
  validate :sale_price_less_than_price
  
  scope :on_sale, -> { where(on_sale: true) }
  scope :featured, -> { where(featured: true) }
  scope :in_stock, -> { where('stock_quantity > ?', 0) }
  
  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "category_id", "stock_quantity", "on_sale", "sale_price", "featured", "created_at", "updated_at", "id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
  
  private
  
  def sale_price_less_than_price
    if on_sale? && sale_price.present? && price.present? && sale_price >= price
      errors.add(:sale_price, "must be less than regular price")
    end
  end
end