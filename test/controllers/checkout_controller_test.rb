# frozen_string_literal: true

require 'test_helper'

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  attr_accessor :user

  setup do
    @user = users(:two)

    sign_in user
  end

  test 'should redirect to cart if cart is empty' do
    sign_in users(:one)
    get checkout_cart_url

    assert_redirected_to cart_url
  end

  test 'should get to checkout page if cart has items' do
    get checkout_cart_url

    assert_response :success
  end

  test 'should redirect to cart if checkout params are invalid' do
    post checkout_cart_url, params: { checkout: {
      cart_number: 'aaaaa',
      cart_expiration_month: 'asdsd',
      shipping_address: '',
      cart_cvv: '123'
    } }

    assert_redirected_to cart_url
  end

  test 'should create checkout if checkout params are valid' do
    post checkout_cart_url, params: { checkout: {
      cart_number: '1234567890123456',
      cart_expiration_month: '12',
      cart_expiration_year: '2023',
      shipping_address: 'address',
      cart_cvv: '123'
    } }

    assert_redirected_to bought_item_url(user)
  end
end
