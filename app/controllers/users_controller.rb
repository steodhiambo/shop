class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @products = current_user.products.order("created_at desc")
    @total_ads = @products.count
    @recent_ads = @products.limit(5)
  end
end
