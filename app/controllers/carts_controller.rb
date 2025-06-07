class CartsController < ApplicationController
  include CurrentCart
  
  before_action :set_cart, only: [:show, :destroy]
  before_action :set_cart_item, only: [:add_item, :remove_item, :remove_all_of_item]

  # GET /cart
  def show
    @cart_items = @cart.items_with_products
  end

  # POST /cart/add_item
  def add_item
    product = Product.find(params[:product_id])
    @cart.add_product(product)
    
    redirect_back(fallback_location: root_path)
    flash[:notice] = "Added to your cart"
  end

  # DELETE /cart/remove_item
  def remove_item
    product = Product.find(params[:product_id])
    @cart.remove_product(product)
    
    redirect_back(fallback_location: cart_path)
    flash[:notice] = "Removed from your cart"
  end

  # DELETE /cart/remove_all_of_item
  def remove_all_of_item
    product = Product.find(params[:product_id])
    @cart.remove_all_of_product(product)
    
    redirect_back(fallback_location: cart_path)
    flash[:notice] = "Removed from your cart"
  end

  # DELETE /cart
  def destroy
    @cart.empty_cart
    redirect_to root_path, notice: 'Cart was successfully emptied.'
  end

  private

  def set_cart_item
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
  end
end
