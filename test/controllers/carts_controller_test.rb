# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should not get show if not signed in' do
    get cart_url

    assert_redirected_to new_user_session_url
  end

  test 'should get show if signed in' do
    sign_in users(:one)
    get cart_url

    assert_response :success
  end
end
