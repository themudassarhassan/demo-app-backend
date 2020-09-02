class Api::CouponsController < ApplicationController
  def verify_coupon
    coupon = Coupon.find_by(name: params[:key])
    if coupon
      render json: { value: coupon.value }, status: 200
    else
      render json: { message: 'Coupon not found.' }, status: 404
    end
  end
end
