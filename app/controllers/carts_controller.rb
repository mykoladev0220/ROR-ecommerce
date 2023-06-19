# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart_total = current_user.cart.total
    @cart_items = current_user_cart_items
  end

  private

  def current_user_cart_items
    current_user.cart_items.includes(:item) || []
  end
end
