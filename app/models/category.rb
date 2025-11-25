class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end
end
