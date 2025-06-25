class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @products = current_user.products.order("created_at desc")
    @ads = current_user.ads.includes(:product).order("created_at desc")
    @total_products = @products.count
    @total_ads = @ads.count
    @recent_products = @products.limit(3)
    @recent_ads = @ads.limit(5)
  end
end
