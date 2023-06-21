# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :current_user_cart

  attr_accessor :cart

  def new
    return unless current_user_cart.cart_items.empty?

    render_response(info: 'You cannot checkout an empty cart.', path: cart_path)
  end

  def create
    if validate_cart_params
      current_user_cart.checkout
      render_response(info: 'Checkout successful.', path: bought_items_path)
    else
      render_response(info: 'Invalid checkout parameters.', path: cart_path)
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
  def validate_cart_params
    checkout_params[:cart_number]&.length == 16 &&
      checkout_params[:cart_cvv]&.length == 3 &&
      checkout_params[:cart_expiration_year]&.length == 4 &&
      checkout_params[:cart_expiration_month]&.length&.between?(1, 2)
  end
end
