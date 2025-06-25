class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :ads, dependent: :destroy

  mount_uploader :image, ImageUploader
  serialize :image, coder: JSON # If you use SQLite, add this line

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed. "}
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed. "}
  validates :price, length: { maximum: 10 }

  # You can input more brands finish and condition here
  BRAND = %w{ Ferrari Opel Lenovo Fossil Apple Samsung Sony Nike Adidas Toyota Honda Other}
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam Silver Gold }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  # Available options for dropdowns (aliases for consistency)
  BRANDS = BRAND
  COLORS = FINISH
  CONDITIONS = CONDITION

  scope :by_brand, ->(brand) { where(brand: brand) if brand.present? }
  scope :by_condition, ->(condition) { where(condition: condition) if condition.present? }
  scope :by_user, ->(user) { where(user: user) if user.present? }
end
