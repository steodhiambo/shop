class Ad < ApplicationRecord
  belongs_to :product
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }
  validates :promotional_text, length: { maximum: 1000 }
  validates :asking_price, presence: true, numericality: { greater_than: 0 }
  validates :contact_method, inclusion: { in: %w[email phone both] }
  
  # Scopes
  scope :active, -> { where(active: true) }
  scope :expired, -> { where('expires_at < ?', Time.current) }
  scope :not_expired, -> { where('expires_at IS NULL OR expires_at > ?', Time.current) }
  scope :by_user, ->(user) { where(user: user) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Contact method options
  CONTACT_METHODS = %w[email phone both].freeze
  
  # Check if ad is still active and not expired
  def active_and_current?
    active? && !expired?
  end
  
  # Check if ad has expired
  def expired?
    expires_at.present? && expires_at < Time.current
  end
  
  # Increment view count
  def increment_views!
    increment!(:views_count)
  end
  
  # Get contact information based on contact method
  def contact_display
    case contact_method
    when 'email'
      user.email
    when 'phone'
      contact_info
    when 'both'
      "#{user.email} | #{contact_info}"
    else
      user.email
    end
  end
  
  # Get the price to display (ad price or product price)
  def display_price
    asking_price.present? ? asking_price : product.price
  end
end
