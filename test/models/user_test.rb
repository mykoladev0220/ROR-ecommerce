# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
    tester = User.create(name: 'test', email: 'test@user.com', password: 'password', password_confirmation: 'password')

    assert_not_nil tester.name
    assert_not_nil tester.cart
  end

  test 'user cart and cart items are destroyed when user is destroyed' do
    assert_not_nil user.cart

    user.destroy

    assert_nil Cart.find_by(id: user.cart.id)
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

    assert_equal 'Quantity is invalid', create.errors.full_messages.first
  end

  test 'user can update the quantity of an item in the cart' do
    CartItem.create(cart:, item: iphone, quantity: 3)

    assert_equal 3, cart.cart_items.first.quantity
    assert_equal 0, iphone.reload.quantity

    cart.cart_items.first.update(quantity: 1)
    assert_equal 1, cart.cart_items.first.quantity
    assert_equal 2, iphone.reload.quantity

    cart.cart_items.first.update(quantity: 2)
    assert_equal 2, cart.cart_items.first.quantity
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

    cart.cart_items.first.remove_from_cart

    assert_equal 0, cart.cart_items.count
    assert_equal 3, iphone.reload.quantity
  end

  test 'user can not enter a negative quantity' do
    create = CartItem.create(cart:, item: iphone, quantity: -1)

    assert_equal 0, cart.cart_items.count
    assert_equal 3, iphone.reload.quantity

    assert_equal 'Quantity must be greater than or equal to 1', create.errors.full_messages.first
  end

  test 'user can get the total price of the cart' do
    CartItem.create(cart:, item: iphone, quantity: 3)
    CartItem.create(cart:, item: ruby_book, quantity: 2)

    assert_equal 400, cart.total
  end

  test 'user can checkout and the cart is emptied' do
    CartItem.create(cart:, item: iphone, quantity: 3)
    CartItem.create(cart:, item: ruby_book, quantity: 3)

    assert_equal 450, cart.total

    user.cart.checkout
    assert_equal 0, cart.cart_items.count
    assert_equal 0, cart.total

    assert_equal 0, iphone.reload.quantity
    assert_equal 0, ruby_book.reload.quantity
  end
end
