class Address < ApplicationRecord
 belongs_to :user
  belongs_to :province

  validates :street_address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true, format: { with: /\A[A-Z]\d[A-Z]\s?\d[A-Z]\d\z/i }
def self.ransackable_attributes(auth_object = nil)
    ["user_id", "street_address", "city", "province_id", "postal_code", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "province"]
  end
end
