class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  # Only validate if address fields are being filled in
  validates :street_address, presence: true, length: { minimum: 5, maximum: 255 }, if: :should_validate?
  validates :city, presence: true, length: { minimum: 2, maximum: 100 }, if: :should_validate?
  validates :postal_code, presence: true,
            format: { with: /\A[A-Z]\d[A-Z]\s?\d[A-Z]\d\z/i, message: "must be a valid Canadian postal code (e.g., A1A 1A1)" },
            if: :should_validate?
  validates :province_id, presence: true, if: :should_validate?

  before_validation :normalize_postal_code

  def self.ransackable_attributes(auth_object = nil)
    [ "street_address", "city", "postal_code", "user_id", "province_id", "created_at", "updated_at", "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "province" ]
  end

  private

  # Only validate if any address field has data
  def should_validate?
    street_address.present? || city.present? || postal_code.present? || province_id.present?
  end

  def normalize_postal_code
    if postal_code.present?
      # Remove spaces and uppercase
      self.postal_code = postal_code.gsub(/\s+/, "").upcase
      # Add space in the middle if not present
      self.postal_code = "#{postal_code[0..2]} #{postal_code[3..5]}" if postal_code.length == 6
    end
  end
end
