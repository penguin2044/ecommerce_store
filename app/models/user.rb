class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true

    def self.ransackable_attributes(auth_object = nil)
    ["email", "first_name", "last_name", "admin", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "orders"]
  end
end
