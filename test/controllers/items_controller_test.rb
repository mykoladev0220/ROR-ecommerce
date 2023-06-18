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
end
