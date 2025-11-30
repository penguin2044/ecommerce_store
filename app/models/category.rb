class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "description", "created_at", "updated_at", "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end
end
