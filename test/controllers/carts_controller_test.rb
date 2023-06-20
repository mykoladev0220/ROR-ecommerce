# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should not get to show if not signed in' do
    get cart_url

    assert_redirected_to new_user_session_url
  end

  test 'should not get to show and return JSON if not signed in' do
    get cart_url, as: :json

    assert_response :unauthorized
  end

  test 'should get to show if signed in' do
    sign_in users(:one)
    get cart_url

    assert_response :success
  end

  # JSON response format test:

  test 'should get show and return JSON' do
    sign_in users(:one)
    get cart_url, as: :json

    result = JSON.parse(response.body)

    assert_equal %w[cart_total cart_items], result.keys
    assert_instance_of Integer, result['cart_total']
    assert_instance_of Array, result['cart_items']
  end
end
