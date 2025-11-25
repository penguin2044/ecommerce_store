class Address < ApplicationRecord
 belongs_to :user
  belongs_to :province

  validates :street_address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true, format: { with: /\A[A-Z]\d[A-Z]\s?\d[A-Z]\d\z/i }
end
