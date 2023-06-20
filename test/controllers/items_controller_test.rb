# frozen_string_literal: true

require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get items_url

    assert_response :success
  end

  test 'should not get to show page if not signed in' do
    get item_url(items(:ruby_book))

    assert_response :redirect
  end

  test 'should get to show page if signed in' do
    sign_in users(:one)
    get item_url(items(:ruby_book))

    assert_response :success
  end

  # JSON response format test:

  test 'should get index and return JSON' do
    get items_url, as: :json

    result = JSON.parse(response.body)

    assert_equal %w[items], result.keys
    assert_instance_of Array, result['items']
    assert_instance_of Integer, result['items'][0]['id']
  end

  test 'should get to show page and return JSON' do
    sign_in users(:one)
    get item_url(items(:ruby_book)), as: :json

    result = JSON.parse(response.body)

    assert_equal %w[item cart_item], result.keys
    assert_instance_of Integer, result['item']['id']
  end
end
