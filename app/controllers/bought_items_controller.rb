# frozen_string_literal: true

class BoughtItemsController < ApplicationController
  def index
    @bought_items = current_user_bought_items
    @total_spending = @bought_items.map(&:subtotal).sum
  end

  private

  def current_user_bought_items
    current_user.bought_items.includes(:item) || []
  end
end
