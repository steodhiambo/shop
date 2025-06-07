class PaymentsController < ApplicationController
  include CurrentCart
  
  before_action :authenticate_user!
  before_action :set_cart
  before_action :ensure_cart_not_empty, only: [:new, :create]
  
  # GET /payments/new
  def new
    @payment = Payment.new
    @total_amount = @cart.total_price
  end
  
  # POST /payments
  def create
    begin
      @payment = Payment.create_payment_intent(@cart, current_user)
      
      render json: {
        client_secret: stripe_payment_intent.client_secret,
        payment_id: @payment.id
      }
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 422
    end
  end
  
  # GET /payments/:id
  def show
    @payment = Payment.find(params[:id])
    
    unless @payment.user == current_user
      redirect_to root_path, alert: 'Not authorized to view this payment.'
      return
    end
  end
  
  # POST /payments/:id/confirm
  def confirm
    @payment = Payment.find(params[:id])
    
    unless @payment.user == current_user
      render json: { error: 'Not authorized' }, status: 403
      return
    end
    
    begin
      # Retrieve the payment intent from Stripe
      payment_intent = Stripe::PaymentIntent.retrieve(@payment.stripe_payment_intent_id)
      @payment.update_from_stripe_event(payment_intent)
      
      if @payment.succeeded?
        render json: { 
          status: 'success', 
          redirect_url: payment_success_path(@payment)
        }
      else
        render json: { 
          status: 'error', 
          message: 'Payment was not successful' 
        }
      end
    rescue Stripe::StripeError => e
      render json: { error: e.message }, status: 422
    end
  end
  
  # GET /payments/:id/success
  def success
    @payment = Payment.find(params[:id])
    
    unless @payment.user == current_user
      redirect_to root_path, alert: 'Not authorized to view this payment.'
      return
    end
    
    unless @payment.succeeded?
      redirect_to cart_path, alert: 'Payment was not successful.'
      return
    end
  end
  
  private
  
  def ensure_cart_not_empty
    if @cart.empty?
      redirect_to cart_path, alert: 'Your cart is empty.'
    end
  end
  
  def stripe_payment_intent
    @stripe_payment_intent ||= Stripe::PaymentIntent.retrieve(@payment.stripe_payment_intent_id)
  end
end
