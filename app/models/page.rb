class Page < ApplicationRecord
   validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :content, presence: true

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
   def self.ransackable_attributes(auth_object = nil)
    ["title", "content", "slug", "created_at", "updated_at", "id"]
  end
end
