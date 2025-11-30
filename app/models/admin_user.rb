class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :password_complexity

  def self.ransackable_attributes(auth_object = nil)
    [ "email", "created_at", "updated_at", "id" ]
  end

  private

  def password_complexity
    return if password.blank?

    unless password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/)
      errors.add :password, "must be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 number, and 1 special character"
    end
  end
end
