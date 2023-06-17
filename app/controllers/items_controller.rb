class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  attr_accessor :item

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.find_by(cart: current_user.cart, item: @item) || CartItem.new
  end
end
