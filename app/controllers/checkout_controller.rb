# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :current_user_cart

  attr_accessor :cart

  def new
    return unless current_user_cart.cart_items.empty?

    flash[:alert] = 'You cannot checkout an empty cart.'
    redirect_to cart_path
  end

  def create
    if validate_params
      current_user_cart.checkout
      flash[:notice] = 'Checkout successful.'
      redirect_to bought_item_path(current_user)
    else
      flash[:alert] = 'Try again later or contact support.'
      redirect_to cart_path
    end
  end

  private

  def current_user_cart
    @cart = current_user.cart
  end

  def checkout_params
    params.require(:checkout)
          .permit(:cart_number, :cart_expiration_month, :cart_expiration_year, :shipping_address, :cart_cvv)
  end

  # Dummy validation for basic checkout simulation.
  def validate_params
    checkout_params[:cart_number].length == 16 &&
      checkout_params[:cart_cvv].length == 3 &&
      checkout_params[:cart_expiration_year].length == 4 &&
      checkout_params[:cart_expiration_month].to_i <= 12
  end
end
