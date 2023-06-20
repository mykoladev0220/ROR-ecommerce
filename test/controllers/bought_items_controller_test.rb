# frozen_string_literal: true

require 'test_helper'

class BoughtItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  attr_accessor :user

  setup do
    @user = users(:two)

    sign_in user
  end

  test 'should get show' do
    get bought_items_url

    assert_response :success
  end

  # JSON response format test:

  test 'should get to show and return JSON' do
    get bought_items_url, as: :json
    result = JSON.parse(response.body)

    assert_equal %w[total_spending bought_items], result.keys
    assert_instance_of Integer, result['total_spending']
    assert_instance_of Array, result['bought_items']
  end
end
