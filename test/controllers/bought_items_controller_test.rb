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
    get bought_item_url(user)

    assert_response :success
  end
end
