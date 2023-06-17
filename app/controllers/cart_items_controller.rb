# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :find_cart_item

  attr_accessor :cart_item

  def create
    @cart_item = CartItem.create(cart_item_params)
    redirect_to_cart_with_flash_notice('Item added to cart.')
  end

  def update
    cart_item.update(quantity: params[:cart_item][:quantity])
    redirect_to_cart_with_flash_notice('Cart item updated.')
  end

  def destroy
    cart_item.remove_from_cart
    redirect_to_cart_with_flash_notice('Cart item deleted.')
  end

  private

  delegate :errors, to: :cart_item

  def find_cart_item
    @cart_item = if params[:id].present?
                   CartItem.find_by(id: params[:id])
                 else
                   CartItem.find_by(cart_item_params.except(:quantity))
                 end
  end

  def redirect_to_cart_with_flash_notice(notice)
    errors.any? ? flash[:alert] = errors.full_messages.join(', ') : flash[:notice] = notice

    redirect_to cart_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id).merge(cart_id: current_user.cart.id)
  end
end
