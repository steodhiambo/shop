module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    @cart = Cart.find(session[:cart_id]) if session[:cart_id]
    
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    
    # If user is signed in and cart doesn't belong to user, assign it
    if user_signed_in? && @cart.user != current_user
      # If user already has a cart, merge the session cart into it
      if current_user.cart.present?
        merge_carts(@cart, current_user.cart)
        @cart.destroy
        @cart = current_user.cart
      else
        @cart.update(user: current_user)
      end
      session[:cart_id] = @cart.id
    end
  end

  def current_cart
    @cart ||= set_cart
  end

  # Merge items from session cart into user cart
  def merge_carts(session_cart, user_cart)
    session_cart.cart_items.each do |session_item|
      existing_item = user_cart.cart_items.find_by(product: session_item.product)
      
      if existing_item
        existing_item.quantity += session_item.quantity
        existing_item.save
      else
        session_item.update(cart: user_cart)
      end
    end
  end
end
