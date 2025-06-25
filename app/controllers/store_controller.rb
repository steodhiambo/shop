class StoreController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:index]

  def index
    @products = Product.all.limit(12) # Show latest 12 products on homepage
    @ads = Ad.active.not_expired.includes(:product, :user).recent.limit(8) # Show latest 8 ads
  end
end
