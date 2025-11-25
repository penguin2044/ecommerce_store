class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates :abbreviation, presence: true, uniqueness: true
end
