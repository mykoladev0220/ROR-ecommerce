# frozen_string_literal: true

class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  attr_accessor :item

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = find_or_new_cart_item
  end

  private

  def find_or_new_cart_item
    CartItem.find_by(cart: current_user.cart, item:) || CartItem.new
  end
end
