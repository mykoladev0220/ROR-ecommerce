# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :find_cart_item, only: %i[update destroy]

  attr_accessor :cart_item

  def create
    @cart_item = CartItem.new(cart_item_params)

    if cart_item.save
      render_response(info: 'Item added to cart.', path:)
    else
      render_response(errors:, path:)
    end
  end

  def update
    if cart_item.update(quantity:)
      render_response(info: 'Cart item updated.', path:)
    else
      render_response(errors:, path:)
    end
  end

  def destroy
    if cart_item.remove_from_cart
      render_response(info: 'Item removed from cart.', path:)
    else
      render_response(errors:, path:)
    end
  end

  private

  delegate :errors, to: :cart_item

  def path
    cart_path
  end

  def find_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def quantity
    @quantity = params[:cart_item][:quantity]
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id).merge(cart_id: current_user.cart.id)
  end
end
