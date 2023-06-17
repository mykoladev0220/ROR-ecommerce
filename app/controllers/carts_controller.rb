# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = current_user.cart
    @cart_items = current_user_cart_items
  end

  private

  def current_user_cart_items
    current_user.cart_items.includes(:item) || []
  end
end
