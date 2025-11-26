class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items, dependent: :destroy
  
  validates :status, presence: true, inclusion: { in: %w[pending paid shipped delivered cancelled] }
  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :pst, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :hst, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :user_id, presence: true
  validates :street_address, length: { maximum: 255, allow_blank: true }
  validates :city, length: { maximum: 100, allow_blank: true }
  validates :postal_code, length: { maximum: 10, allow_blank: true }, 
            format: { with: /\A[A-Z]\d[A-Z]\s?\d[A-Z]\d\z/i, allow_blank: true, message: "must be a valid Canadian postal code" }
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "pst", "status", "subtotal", "total", "user_id", "updated_at", "street_address", "city", "postal_code", "province_id", "stripe_payment_intent_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user", "province"]
  end
end