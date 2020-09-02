Stripe.api_key = 'sk_test_E3gWBb7326SJe8ACeGdhGlJy00FEgaF63B'

class Api::OrdersController < ApplicationController
  def create_payment_intent
    user = get_current_user
    totalPrice = calculate_order_amount
    print("total price ### #{totalPrice}")
    payment_intent = Stripe::PaymentIntent.create(
      amount: totalPrice,
      currency: 'pkr'
    )
    render json: payment_intent[:client_secret], status: 200
  end

  private

  def calculate_order_amount
    total = 0
    params[:items].each { |item| total += item[:price] * item[:quantity] }
    total
   end
end
