class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :stripe_payment_intent_id, presence: true
  validates :status, presence: true
  
  enum status: {
    pending: 'pending',
    processing: 'processing',
    succeeded: 'succeeded',
    failed: 'failed',
    canceled: 'canceled'
  }
  
  # Create a Stripe PaymentIntent
  def self.create_payment_intent(cart, user)
    amount_in_cents = (cart.total_price * 100).to_i
    
    payment_intent = Stripe::PaymentIntent.create({
      amount: amount_in_cents,
      currency: 'usd',
      metadata: {
        cart_id: cart.id,
        user_id: user.id
      }
    })
    
    Payment.create!(
      user: user,
      cart: cart,
      amount: cart.total_price,
      stripe_payment_intent_id: payment_intent.id,
      status: 'pending'
    )
  end
  
  # Update payment status based on Stripe webhook
  def update_from_stripe_event(stripe_payment_intent)
    case stripe_payment_intent.status
    when 'processing'
      update!(status: 'processing')
    when 'succeeded'
      update!(status: 'succeeded')
      # Clear the cart after successful payment
      cart.empty_cart
    when 'payment_failed'
      update!(status: 'failed')
    when 'canceled'
      update!(status: 'canceled')
    end
  end
end
