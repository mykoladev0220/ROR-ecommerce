# frozen_string_literal: true

class BoughtItemsController < ApplicationController
  def show
    @bought_items = current_user_bought_items
  end

  private

  def current_user_bought_items
    current_user.bought_items.includes(:item) || []
  end
end
