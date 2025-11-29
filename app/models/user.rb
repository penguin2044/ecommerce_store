class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  
  # allows nested address attributes in forms
  accepts_nested_attributes_for :address, allow_destroy: true
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 50 }
  validate :password_complexity
  
  def self.ransackable_attributes(auth_object = nil)
    ["email", "first_name", "last_name", "created_at", "updated_at", "id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["orders", "address"]
  end
  
  private
  
  def password_complexity
    return if password.blank?
    
    unless password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/)
      errors.add :password, 'must be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 number, and 1 special character'
    end
  end
end