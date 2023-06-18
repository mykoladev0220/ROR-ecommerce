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
require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  test 'cart item has a cart and an item' do
    cart_item = CartItem.create(cart: carts(:one), item: items(:ruby_book), quantity: 1)

    assert_not_nil cart_item.cart
    assert_not_nil cart_item.item
  end
end
