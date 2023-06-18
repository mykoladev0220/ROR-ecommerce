# frozen_string_literal: true

# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  quantity   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :integer          not null
#  item_id    :integer          not null
#
# Indexes
#
#  index_cart_items_on_cart_id              (cart_id)
#  index_cart_items_on_cart_id_and_item_id  (cart_id,item_id) UNIQUE
#  index_cart_items_on_item_id              (item_id)
#
# Foreign Keys
#
#  cart_id  (cart_id => carts.id)
#  item_id  (item_id => items.id)
#
class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  validates :item, uniqueness: { scope: :cart }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  before_create :item_exists_in_stock?
  before_update :update_stock_quantity
  after_create :reduce_item_from_the_stock

  delegate :name, :price, to: :item
  delegate :quantity, to: :item, prefix: :stock

  # The reason there is no callback for the destroy method is
  # because we don't want to add the item back to the stock
  # if the cart item is destroyed when checkout is called.
  def remove_from_cart
    add_item_back_to_the_stock
    destroy
  end

  private

  def update_stock_quantity
    return unless quantity_changed?

    return_amount = quantity_was - quantity
    take_amount = quantity - quantity_was

    quantity_was > quantity ? add_item_back_to_the_stock(return_amount) : reduce_item_from_the_stock(take_amount)
  end

  def add_item_back_to_the_stock(amount = quantity)
    new_quantity = stock_quantity + amount
    item.update(quantity: new_quantity)
  end

  def reduce_item_from_the_stock(amount = quantity)
    new_quantity = stock_quantity - amount

    throw_error if new_quantity.negative?

    item.update(quantity: new_quantity)
  end

  def item_exists_in_stock?
    return true if stock_quantity >= quantity

    throw_error
  end

  def throw_error
    errors.add(:quantity)
    throw(:abort)
  end
end
