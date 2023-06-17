# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  before_create :item_exists_in_stock

  before_update :update_stock_quantity

  after_create :reduce_item_from_the_stock

  before_destroy :add_item_back_to_the_stock

  validates :item, uniqueness: { scope: :cart }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  private

  def update_stock_quantity
    return unless quantity_changed?

    quantity_was > quantity ? add_item_back_to_the_stock : reduce_item_from_the_stock
  end

  def item_exists_in_stock
    return true if item.quantity >= quantity

    errors.add(:quantity, 'is greater than the stock')
    throw(:abort)
  end

  def reduce_item_from_the_stock
    item.update(quantity: item.quantity - quantity) if item_exists_in_stock
  end

  def add_item_back_to_the_stock
    return_amount = quantity_changed? ? quantity_was - quantity : quantity
    new_quantity = item.quantity + return_amount

    item.update(quantity: new_quantity)
  end
end
