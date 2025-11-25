class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates :abbreviation, presence: true, uniqueness: true
  def self.ransackable_attributes(auth_object = nil)
    ["name", "abbreviation", "gst_rate", "pst_rate", "hst_rate", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["addresses"]
  end
end
