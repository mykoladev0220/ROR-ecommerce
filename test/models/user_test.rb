# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_accessor :user, :cart, :ruby_book, :iphone, :bugatti

  setup do
    @user = users(:one)
    @cart = carts(:one)
    @ruby_book = items(:ruby_book)
    @iphone = items(:iphone)
    @bugatti = items(:bugatti)
  end

  test 'user has a cart on create' do
    assert_not_nil user.cart
  end

  test 'user can add item to cart and reduce from the stock' do
    CartItem.create(cart:, item: iphone, quantity: 3)

    assert_equal 1, cart.cart_items.count
    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity
  end

  test 'user can not add more than the stock and error is raised' do
    create = CartItem.create(cart:, item: iphone, quantity: 10)

    assert_equal 0, cart.cart_items.count
    assert_equal 3, iphone.reload.quantity

    assert_equal 'Quantity is greater than the stock', create.errors.full_messages.first
  end

  test 'user can update the quantity of an item in the cart' do
    CartItem.create(cart:, item: iphone, quantity: 3)

    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity

    cart.cart_items.first.update(quantity: 1)
    assert_equal 1, cart.cart_items.first.quantity
    assert_equal 2, iphone.reload.quantity
  end

  test 'user can not update the quantity of an item in the cart if the quantity is greater than the stock' do
    CartItem.create(cart:, item: iphone, quantity: 3)

    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity

    update = cart.cart_items.first.update(quantity: 10)

    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity
    assert_equal false, update
  end

  test 'user can delete an item from the cart and add it back to the stock' do
    CartItem.create(cart:, item: iphone, quantity: 3)

    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity

    cart.cart_items.first.destroy

    assert_equal 0, cart.cart_items.count
    assert_equal 3, iphone.reload.quantity
  end

  test 'user can not enter a negative quantity' do
    create = CartItem.create(cart:, item: iphone, quantity: -1)

    assert_equal 0, cart.cart_items.count
    assert_equal 3, iphone.reload.quantity

    assert_equal 'Quantity must be greater than or equal to 1', create.errors.full_messages.first
  end
end
