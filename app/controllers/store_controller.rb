class StoreController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: [:index]

  def index
    @products = Product.all.limit(12) # Show latest 12 products on homepage
  end
end
