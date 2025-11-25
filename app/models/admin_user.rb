class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # Password requirements
  validate :password_complexity

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def password_complexity
    return if password.blank?

    # At least 8 characters
    if password.length < 8
      errors.add :password, "must be at least 8 characters long"
    end

    # Must contain at least one uppercase letter
    unless password.match?(/[A-Z]/)
      errors.add :password, "must contain at least one uppercase letter"
    end

    # Must contain at least one lowercase letter
    unless password.match?(/[a-z]/)
      errors.add :password, "must contain at least one lowercase letter"
    end

    # Must contain at least one number
    unless password.match?(/[0-9]/)
      errors.add :password, "must contain at least one number"
    end

    # Must contain at least one special character
    unless password.match?(/[!@#$%^&*(),.?":{}|<>]/)
      errors.add :password, "must contain at least one special character (!@#$%^&*)"
    end
  end
end