# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  attr_accessor :user, :cart

  setup do
    @user = users(:one)
    @cart = carts(:one)
  end

  test 'cart has a user' do
    assert_not_nil cart.user
  end

  test 'cart has cart items' do
    cart.cart_items.create(item: items(:ruby_book), quantity: 1)

    assert_not_nil cart.cart_items
  end

  test 'cart has a total' do
    cart.cart_items.create(item: items(:ruby_book), quantity: 1)
    cart.cart_items.create(item: items(:iphone), quantity: 1)

    assert_equal 150, cart.total
  end

  test 'cart can checkout' do
    cart.cart_items.create(item: items(:iphone), quantity: 1)

    assert_difference 'BoughtItem.count', 1 do
      cart.checkout
    end

    assert_equal 0, cart.total
    assert_equal 0, cart.cart_items.count
  end
end
