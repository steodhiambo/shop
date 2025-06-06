class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :payments, dependent: :destroy
  belongs_to :user, optional: true

  # Add a product to the cart
  def add_product(product)
    current_item = cart_items.find_by(product: product)
    
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      cart_items.create(product: product, quantity: 1)
    end
  end

  # Remove a product from the cart
  def remove_product(product)
    current_item = cart_items.find_by(product: product)
    
    if current_item
      if current_item.quantity > 1
        current_item.quantity -= 1
        current_item.save
      else
        current_item.destroy
      end
    end
  end

  # Remove all instances of a product from the cart
  def remove_all_of_product(product)
    cart_items.where(product: product).destroy_all
  end

  # Calculate total price of all items in cart
  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  # Get total number of items in cart
  def total_items
    cart_items.sum(:quantity)
  end

  # Empty the cart
  def empty_cart
    cart_items.destroy_all
  end

  # Check if cart is empty
  def empty?
    cart_items.empty?
  end

  # Get all cart items with their products
  def items_with_products
    cart_items.includes(:product)
  end
end
