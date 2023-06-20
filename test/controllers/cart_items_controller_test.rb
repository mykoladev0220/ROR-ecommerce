# frozen_string_literal: true

require 'test_helper'

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  attr_accessor :user, :cart, :cart_item

  setup do
    @user = users(:one)
    @cart = carts(:one)
    @cart_item = cart_items(:two)

    sign_in user
  end

  test 'should create cart item' do
    assert_difference 'CartItem.count', 1 do
      post cart_items_url, params: { cart_item: { item_id: items(:ruby_book).id, quantity: 1 } }
    end

    assert_redirected_to cart_path
  end

  test 'should update cart item' do
    assert_difference 'cart_item.reload.quantity', 1 do
      patch cart_item_url(cart_item), params: { cart_item: { quantity: 2 } }
    end

    assert_redirected_to cart_path
  end

  test 'should not update the cart item with insane numbers' do
    assert_difference 'cart_item.reload.quantity', 0 do
      patch cart_item_url(cart_item), params: { cart_item: { quantity: 9999 } }
      patch cart_item_url(cart_item), params: { cart_item: { quantity: -1111 } }
    end

    assert_redirected_to cart_path
  end

  test 'should destroy cart item' do
    assert_equal Item.total_stock_count, 9

    assert_difference 'CartItem.count', -1 do
      delete cart_item_url(cart_item)
    end

    assert_equal Item.total_stock_count, 10

    assert_redirected_to cart_path
  end

  # JSON response format test:

  test 'shoud create cart item and return JSON' do
    assert_difference 'CartItem.count', 1 do
      post cart_items_url, params: { cart_item: { item_id: items(:ruby_book).id, quantity: 1 } }, as: :json
    end

    result = JSON.parse(response.body)

    assert_equal %w[message cart_item], result.keys
    assert_equal 'Item added to cart.', result['message']
  end

  test 'should not update the cart item with insane numbers and return JSON' do
    assert_difference 'cart_item.reload.quantity', 0 do
      patch cart_item_url(cart_item), params: { cart_item: { quantity: 9999 } }, as: :json
      patch cart_item_url(cart_item), params: { cart_item: { quantity: -1111 } }, as: :json
    end

    result = JSON.parse(response.body)

    assert_equal %w[message cart_item], result.keys
    assert_equal 'Quantity must be greater than or equal to 1', result['message']
  end

  test 'should update cart item and return JSON' do
    assert_difference 'cart_item.reload.quantity', 1 do
      patch cart_item_url(cart_item), params: { cart_item: { quantity: 2 } }, as: :json
    end

    result = JSON.parse(response.body)

    assert_equal %w[message cart_item], result.keys
    assert_equal 'Cart item updated.', result['message']
  end

  test 'should destroy cart item and return JSON' do
    assert_equal Item.total_stock_count, 9

    assert_difference 'CartItem.count', -1 do
      delete cart_item_url(cart_item), as: :json
    end

    assert_equal Item.total_stock_count, 10

    result = JSON.parse(response.body)

    assert_equal %w[message], result.keys
    assert_equal 'Item removed from cart.', result['message']
  end
end
