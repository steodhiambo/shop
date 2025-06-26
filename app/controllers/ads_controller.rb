class AdsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /ads
  def index
    @ads = Ad.active.not_expired.includes(:product, :user).recent
    @ads = @ads.by_user(params[:user_id]) if params[:user_id].present?
  end

  # GET /ads/my_ads
  def my_ads
    @ads = current_user.ads.includes(:product).recent
    render :index
  end

  # GET /ads/1
  def show
    @ad.increment_views!
    @product = @ad.product
  end

  # GET /ads/new
  def new
    @ad = current_user.ads.build
    @products = current_user.products.order(:title)
    
    if @products.empty?
      redirect_to new_product_path, alert: 'You need to create a product first before creating an ad.'
      return
    end
  end

  # GET /ads/1/edit
  def edit
    @products = current_user.products.order(:title)
  end

  # POST /ads
  def create
    @ad = current_user.ads.build(ad_params)
    
    if @ad.save
      redirect_to @ad, notice: 'Ad was successfully created and is now live!'
    else
      @products = current_user.products.order(:title)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ads/1
  def update
    if @ad.update(ad_params)
      redirect_to @ad, notice: 'Ad was successfully updated.'
    else
      @products = current_user.products.order(:title)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /ads/1
  def destroy
    @ad.destroy
    redirect_to my_ads_ads_path, notice: 'Ad was successfully deleted.'
  end

  # POST /ads/1/toggle_active
  def toggle_active
    @ad = current_user.ads.find(params[:id])
    @ad.update(active: !@ad.active?)
    
    status = @ad.active? ? 'activated' : 'deactivated'
    redirect_back(fallback_location: my_ads_ads_path, notice: "Ad was #{status}.")
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def check_owner
    unless @ad.user == current_user
      redirect_to ads_path, alert: 'Not authorized to perform this action.'
    end
  end

  def ad_params
    params.require(:ad).permit(:title, :description, :promotional_text, :asking_price, 
                               :expires_at, :contact_method, :contact_info, :product_id, :active)
  end
end
