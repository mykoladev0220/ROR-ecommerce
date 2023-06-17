# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :find_cart_item

  attr_accessor :cart_item

  def create
    card_item = CartItem.create(cart_item_params)
    if card_item.valid?
      flash[:notice] = 'Item added to cart'
    else
      flash[:alert] = 'Item not added to cart'
    end
    redirect_to cart_path
  end

  def update
    if cart_item.update(quantity: params[:cart_item][:quantity])
      flash[:notice] = 'Cart item updated'
    else
      flash[:alert] = 'Cart item not updated'
    end

    redirect_to cart_path
  end

  def destroy
    if cart_item.remove_from_cart
      flash[:notice] = 'Cart item deleted'
    else
      flash[:alert] = 'Cart item not deleted'
    end

    redirect_to cart_path
  end

  private

  def find_cart_item
    @cart_item = if params[:id].present?
                   CartItem.find_by(id: params[:id])
                 else
                   CartItem.find_by(cart_item_params.except(:quantity))
                 end
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id).merge(cart_id: current_user.cart.id)
  end
end
